import * as log from "https://deno.land/std@0.109.0/log/mod.ts";

import { cac } from "https://unpkg.com/cac@6.7.14/mod.ts";
import { open } from "https://denopkg.com/hashrock/deno-opn@master/mod.ts";

import { editor } from "../utils.ts";

export async function main(file: string, options = { wait: true }) {
  const editorCommand = await editor(options);
  log.info(`Opening ${file} with ${editorCommand[0]}`);
  await open(file, { with: editorCommand });
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli
  .command("<file>", "Edit <file> with available editor")
  .option("--wait", "Wait for editor to return", { default: true })
  .action(async (file: string, options: { wait: boolean }) => {
    await main(file, options);
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
