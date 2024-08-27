import * as log from "jsr:@std/log@^0.224.6";

import { cac } from "https://unpkg.com/cac@6.7.14/mod.ts";

import { invoke } from "../utils.ts";

export async function main(
  pod: string | undefined,
) {
  // Use AWS_PROFILE environment variable to determine the pod
  pod ??= Deno.env.get("AWS_PROFILE");

  if (!pod) {
    log.info(
      `Pod not provided and not detected in AWS_PROFILE environment variable`,
    );
    return;
  }

  const gatewayUrl = `https://gateway1.${pod}.activeeye.com/gateway`;
  log.info(`Opening ${gatewayUrl} in the browser...`);
  await invoke(["xdg-open", gatewayUrl]);
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli
  .command("[pod]", "Name of the pod to gateway")
  .action(
    async (
      pod: string | undefined,
    ) => {
      await main(pod);
    },
  );
cli.help();

if (import.meta.main) {
  try {
    cli.parse();
  } catch (e) {
    log.error(e);
    cli.outputHelp();
  }
}
