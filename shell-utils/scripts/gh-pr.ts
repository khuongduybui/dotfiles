import * as log from "https://deno.land/std@0.129.0/log/mod.ts";
import { join } from "https://deno.land/std@0.129.0/path/mod.ts";

import { cac } from "https://unpkg.com/cac@6.7.12/mod.ts";
import {
  exec,
  OutputMode,
} from "https://raw.githubusercontent.com/gpasq/deno-exec/master/mod.ts";
import {
  currentDirectory,
  gitBranch,
  invoke,
  parentDirectory,
  siblingDirectories,
} from "../utils.ts";

export async function main(base: string) {
  const branch = await gitBranch();
  log.info(`Creating a PR from ${branch} to ${base}`);
  await invoke(["gh", "pr", "create", "--base", base], { env: { DEBUG: "" } });

  const title = (
    await exec(
      "gh pr view --jq .title --json title",
      {
        output: OutputMode.Capture,
        env: { DEBUG: "" },
      },
    )
  ).output.trim();
  const url = (
    await exec(
      "gh pr view --jq .url --json url",
      {
        output: OutputMode.Capture,
        env: { DEBUG: "" },
      },
    )
  ).output.trim();
  // log.info({ title, url });

  // log.info(currentDirectory);
  // log.info(parentDirectory);
  const otherRepos = (await siblingDirectories()).filter(
    (dir) => dir !== currentDirectory()
  );
  // log.info(otherRepos);
  let subPrs = 0;
  await Promise.all(
    otherRepos.map(async (repo) => {
      const path = join(parentDirectory(), repo);
      const currentBranch = await gitBranch(path);
      if (currentBranch === branch) {
        log.info(
          `Creating a sub PR for ${repo} from ${currentBranch} to ${base}`
        );
        await exec(
          `gh pr create --base "${base}" --title "${title}" --body "See ${url}"`,
          { output: OutputMode.None, cwd: path, env: { DEBUG: "" } }
        );
        const pr = await exec(`gh pr view --jq .url --json url`, {
          output: OutputMode.Capture,
          cwd: path,
          env: { DEBUG: "" },
        });
        log.info(`Created sub PR: ${pr.output.trim()}`);
        subPrs++;
      } else {
        log.info(`Skipping ${repo}, which is on ${currentBranch} branch.`);
      }
    })
  );

  if (subPrs > 0) {
    await exec(
      `gh pr comment --body "Please review along with ${subPrs} related PR${
        subPrs > 1 ? "s" : ""
      }."`,
      { output: OutputMode.StdOut, env: { DEBUG: "" } }
    );
  }
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
// cli.command("", "Command description")
cli
  .command(
    "[base]",
    "The base branch to create a PR against, defaults to master"
  )
  //   .option("--foo", "Some boolean option")
  //   .option("--bar <bar>", "Some text option")
  //   .option("--foobar [foobar]", "Some text or boolean option", { default: true })
  //   .action(async (argument = "default value", options: { foo: boolean, bar: string, foobar: boolean | string }) => {
  .action(async (base = "master") => {
    await main(base);
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
