import * as log from "https://deno.land/std@0.129.0/log/mod.ts";

import { cac } from "https://unpkg.com/cac@6.7.14/mod.ts";
import {
  currentDirectory,
  executable,
  fuzzy,
  gitTags,
  invokeOutput,
  user,
} from "../utils.ts";

export async function main(tag: string | undefined, options: options) {
  if (!tag) {
    const tags = (await gitTags()).split("\n");
    tag = await fuzzy(["fish", "-c"], "", tags);
  }
  if (!tag) {
    throw new Error("No tag provided, found at HEAD, or chosen from the list");
  }
  // @TODO: git show-ref --tags | grep -F "refs/tags/${tag}" to confirm the tag has been pushed

  if (!options.password) {
    throw new Error("No JENKINS_API environment variable found");
  }
  const basicAuthString = `${options.username}:${options.password}`;
  const basicAuthToken = btoa(basicAuthString);
  const endpoint = "https://jenkins1.hawk.activeeye.com/job";
  log.info(`Schedule a build with ${tag} in ${endpoint}/${options.repo}-tags`);
  const response = await fetch(
    `${endpoint}/${options.repo}-tags/buildWithParameters`,
    {
      method: "POST",
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Authorization": `Basic ${basicAuthToken}`,
      },
      body: `tag=${tag}`,
    },
  );
  if (!response.ok) {
    response.body?.pipeTo(Deno.stderr.writable);
    throw new Error("Something went wrong");
  }
}

const getDefaultRepo = async () => {
  if (await executable("gh")) {
    return invokeOutput([
      "gh",
      "repo",
      "view",
      "--json",
      "name",
      "--jq",
      ".name",
    ]);
  }
  return currentDirectory();
};

type options = { repo: string; username: string; password: string | undefined };
const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli.command("[tag]", "Schedule a tag build in Jenkins")
  .option("--repo <repo>", "repo, default: current directory GitHub repo", {
    default: await getDefaultRepo(),
  })
  .option(
    "--username <username>",
    "Jenkins username, default: $JENKINS_USER environment variable, or $(whoami)@motorolasolutions.com",
    {
      default: Deno.env.get("JENKINS_USER") ??
        `${user()}@motorolasolutions.com`,
    },
  )
  .option(
    "--password <password>",
    "Jenkins password, default: $JENKINS_API environment variable",
    {
      default: Deno.env.get("JENKINS_API"),
    },
  )
  .action(async (tag: string | undefined, options: options) => {
    await main(tag, options);
  });
cli.help();

if (import.meta.main) {
  try {
    cli.parse();
  } catch (e) {
    log.error(e);
    cli.outputHelp();
  }
}
