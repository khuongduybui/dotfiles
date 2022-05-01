import * as log from "https://deno.land/std@0.109.0/log/mod.ts";
// import * as path from "https://deno.land/std@0.109.0/path/mod.ts";
import { v4 as uuid } from "https://deno.land/std@0.109.0/uuid/mod.ts";

import { cac } from "https://unpkg.com/cac/mod.ts";
// import { decode as parseIni } from "https://deno.land/x/ini/mod.ts";
import { STS } from "https://deno.land/x/aws_sdk@v3.32.0-1/client-sts/mod.ts";

import { fuzzyShell, user } from "../utils.ts";
// import { homeDirectory } from "../utils.ts";

export async function main(profile?: string) {
  if (profile) {
    // const configPath = path.join(await homeDirectory(), ".aws", "config");
    // const configRaw = await Deno.readTextFile(configPath);
    // const config = await parseIni(configRaw);
    // log.debug(config);
    // const profiles = Object.keys(config).filter((key) =>
    //   key === "default" || key.startsWith("profile ")
    // ).map((key) => key.replace("profile ", ""));
    // log.debug(profiles);
    const selected = await fuzzyShell(
      ["fish", "-c"],
      profile,
      `cat ~/.aws/config | grep -e '\\[profile' | sed -e 's/\\[profile //' -e 's/\\]//'`
    );
    Deno.env.set("AWS_PROFILE", selected);
    log.info(`Selecting profile ${Deno.env.get("AWS_PROFILE")}`);
  }

  log.info("Obtaining permission");
  const username = await user();
  const sts = new STS({});
  const { Credentials: credentials } = await sts.getFederationToken({
    Name: username,
    Policy: JSON.stringify({
      Statement: [{ Effect: "Allow", Action: "*", Resource: "*" }],
    }),
  });
  if (!credentials) {
    return log.error("Cannot obtain permission");
  }
  const session = {
    sessionId: credentials?.AccessKeyId,
    sessionKey: credentials?.SecretAccessKey,
    sessionToken: credentials?.SessionToken,
  };
  log.debug(session);

  log.info("Obtaining signin token");
  const signinUrl = `https://signin.aws.amazon.com/federation?Action=getSigninToken&Session=${encodeURIComponent(
    JSON.stringify(session)
  )}`;
  log.debug(signinUrl);
  const signin = await fetch(signinUrl);
  if (signin.status != 200) {
    return log.error("Cannot obtain signin token");
  }
  log.debug(signin);
  const { SigninToken: token } = await signin.json();
  if (!token) {
    return log.error("Cannot obtain signin token");
  }
  log.debug(token);

  log.info("Generating shortened URL");
  const fullUrl = `https://signin.aws.amazon.com/federation?Action=login&Destination=${encodeURIComponent(
    "https://console.aws.amazon.com"
  )}&SigninToken=${encodeURIComponent(token)}`;
  log.debug(fullUrl);
  const shortenUrl = `https://cutt.ly/api/api.php?key=a2967c0ad7db4197d8244182b087888e05a64&name=aws-${profile}-${username}-${uuid.generate()}&short=${encodeURIComponent(
    fullUrl
  )}`;
  log.debug(shortenUrl);
  const shorten = await fetch(shortenUrl);
  if (shorten.status != 200) {
    log.warning("Cannot generate shortened URL");
  } else {
    log.debug(shorten);
    const {
      url: { shortLink },
    } = await shorten.json();
    if (!shortLink) {
      log.warning("Cannot generate shortened URL");
    } else {
      log.warning(`TODO: open in browser`);
      return log.info(shortLink);
    }
  }
  log.info(fullUrl);
  log.warning(`TODO: open in browser`);
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli
  .command("[profile]", "Open AWS console")
  .action(async (profile?: string) => {
    await main(profile);
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
