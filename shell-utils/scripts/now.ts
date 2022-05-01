import * as log from "https://deno.land/std@0.109.0/log/mod.ts";

import { cac } from "https://unpkg.com/cac/mod.ts";

export function main(options: { ms: boolean }) {
  const now = new Date().getTime();
  return options.ms ? now : Math.round(now / 1000);
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli
  .command("", "Return UNIX timestamp")
  .option("--ms", "Return timestamp in millisecond instead")
  .action(async (options: { ms: boolean }) => {
    console.log(await main(options));
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
