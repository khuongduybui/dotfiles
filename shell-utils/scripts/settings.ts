import * as fs from "https://deno.land/std@0.109.0/fs/mod.ts";
import * as log from "https://deno.land/std@0.109.0/log/mod.ts";
import * as path from "https://deno.land/std@0.109.0/path/mod.ts";

import { cac } from "https://unpkg.com/cac/mod.ts";

import { main as edit } from "./edit.ts";
import { homeDirectory, invokeShell } from "../utils.ts";

export async function main(
  scriptName: string | undefined,
  options: { function: boolean; script: boolean }
) {
  if (!scriptName) {
    const configPath = path.join(
      await homeDirectory(),
      "dotfiles",
      "dotfiles.code-workspace"
    );
    return edit(configPath);
  }

  const functionPath = path.join(
    await homeDirectory(),
    "dotfiles",
    "fish-functions",
    `${scriptName}.fish`
  );
  if (
    !options.script &&
    (options.function || (await fs.exists(functionPath)))
  ) {
    log.info(`Editing fish function ${scriptName}`);
    return invokeShell(["fish", "-c"], ["funced", "-s", scriptName]);
  }

  const scriptPath = path.join(
    await homeDirectory(),
    "dotfiles",
    "shell-utils",
    "scripts",
    `${scriptName}.ts`
  );
  log.info(`Editing ~/dotfiles/shell-utils/scripts/${scriptName}`);
  return edit(scriptPath);
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli
  .command("[scriptName]", "Name of the script to edit")
  .option("--function", "Force editing a fish function", { default: false })
  .option("--script", "Force editing a shell-utils script", { default: false })
  .action(
    async (
      scriptName: string | undefined,
      options: { function: boolean; script: boolean }
    ) => {
      await main(scriptName, options);
    }
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
