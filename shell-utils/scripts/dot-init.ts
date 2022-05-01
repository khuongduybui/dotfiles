import * as log from "https://deno.land/std@0.129.0/log/mod.ts";
import * as path from "https://deno.land/std@0.129.0/path/mod.ts";

import { cac } from "https://unpkg.com/cac@6.7.12/mod.ts";

import { homeDirectory, pathExists, windowsToWslPath } from "../utils.ts";

export async function main({ force }: options) {
  const home = homeDirectory();
  const winhome = path.join(home, "winhome");
  const onedrive = path.join(winhome, "OneDrive");
  const storage = path.join(onedrive, "Essentials");
  log.info(`Processing dotfiles in ${storage}...`);

  for await (const file of Deno.readDir(storage)) {
    if (file.name.startsWith("dotfile")) {
      const destinationName = file.name.replace("dotfile", "");
      const destinationPath = path.join(winhome, destinationName);
      const sourcePath = path.join(storage, file.name);
      log.debug(file);
      if (await pathExists(destinationPath)) {
        log.warning(`${destinationPath} already exists.`);
        if (force) {
          // @TODO backup and replace with Symlink if not Symlink
        }
      } else {
        await Deno.symlink(sourcePath, destinationPath);
        log.info(`${destinationPath} created.`);
      }
    }
  }

  const appStorage = path.join(storage, "AppData");
  log.info(`Processing AppData in ${appStorage}...`);
  for await (const app of Deno.readDir(appStorage)) {
    if (app.isDirectory) {
      const appPath = path.join(appStorage, app.name);
      const wherePath = path.join(appPath, "where.txt");
      log.debug(wherePath);
      if (await pathExists(wherePath)) {
        log.info(`Processing ${app.name}...`);
        const decoder = new TextDecoder("utf-8");
        const data = await Deno.readFile(wherePath);
        const where = decoder.decode(data);
        if (where.includes("\\")) {
          log.debug(`Windows path detected: ${where}.`);
          const wslWhere = await windowsToWslPath(where);
          log.debug(wslWhere);
          if (await pathExists(wslWhere)) {
            for await (const file of Deno.readDir(appPath)) {
              if (!file.name.endsWith("where.txt")) {
                const destinationPath = path.join(wslWhere, file.name);
                if (await pathExists(destinationPath)) {
                  log.warning(`${destinationPath} already exists.`);
                  if (force) {
                    // @TODO backup and replace with Symlink if not Symlink
                  }
                } else {
                  const sourcePath = path.join(appPath, file.name);
                  try {
                    await Deno.symlink(sourcePath, destinationPath);
                    log.info(`${destinationPath} created.`);
                  } catch (e) {
                    log.warning(`${destinationPath} could not be created.`);
                    log.error(e);
                  }
                }
              }
            }
          } else {
            log.warning(`${wslWhere} not found.`);
          }
        } else {
          log.debug(`Linux path detected: ${where}.`);
          const wslWhere = where.replace("~", home);
          log.debug(wslWhere);
          if (await pathExists(wslWhere)) {
            for await (const file of Deno.readDir(appPath)) {
              if (!file.name.endsWith("where.txt")) {
                const destinationPath = path.join(wslWhere, file.name);
                if (await pathExists(destinationPath)) {
                  log.warning(`${destinationPath} already exists.`);
                  if (force) {
                    // @TODO backup and replace with Symlink if not Symlink
                  }
                } else {
                  const sourcePath = path.join(appPath, file.name);
                  try {
                    await Deno.symlink(sourcePath, destinationPath);
                    log.info(`${destinationPath} created.`);
                  } catch (e) {
                    log.warning(`${destinationPath} could not be created.`);
                    log.error(e);
                  }
                }
              }
            }
          } else {
            log.warning(`${wslWhere} not found.`);
          }
        }
      } else {
        log.warning(`${wherePath} not found.`);
      }
    }
  }

  await Promise.resolve();
}
type options = { force: boolean };
const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli
  .command("", "Command description")
  .option("--force", "Backup and replace existing files with symlinks")
  .action(async ({ force }: options) => {
    await main({ force });
  });
cli.help();

if (import.meta.main) {
  log.critical("This cannot be run in WSL.");
  // try {
  //   cli.parse();
  // } catch (e) {
  //   log.error(e);
  //   cli.outputHelp();
  // }
}
