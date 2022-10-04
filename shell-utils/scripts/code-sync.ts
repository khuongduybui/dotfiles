import * as fs from "https://deno.land/std@0.109.0/fs/mod.ts";
import * as log from "https://deno.land/std@0.109.0/log/mod.ts";
import * as path from "https://deno.land/std@0.109.0/path/mod.ts";

import { cac } from "https://unpkg.com/cac@6.7.14/mod.ts";
import json5 from "https://cdn.skypack.dev/json5?dts";

import { homeDirectory } from "../utils.ts";

export async function ensureCodeDir(): Promise<string> {
  const codeDir = path.join(await homeDirectory(), "code");
  const workspacesDir = path.join(await homeDirectory(), "workspaces");
  await Promise.all([
    fs.ensureDir(codeDir),
    fs.ensureSymlink(codeDir, workspacesDir),
  ]);
  return codeDir;
}

export function isDevcontainer(projectPath: string): Promise<boolean> {
  const devcontainerPath = path.join(projectPath, ".devcontainer");
  return fs.exists(devcontainerPath);
}

export async function processProjectDir(
  codeDir: string,
  projectDir: { path: string; name: string },
) {
  log.info(`Processing ${projectDir.name}`);
  const extension = "code-workspace";
  const workspacePath = path.join(codeDir, `${projectDir.name}.${extension}`);
  const hasWorkspaceFile = await fs.exists(workspacePath);
  const workspaceContent: {
    folders: { path: string }[];
    settings: Record<string, unknown>;
  } = hasWorkspaceFile
    ? json5.parse(await Deno.readTextFile(workspacePath))
    : { folders: [], settings: {} };

  const folders: Set<string> = new Set(
    workspaceContent.folders
      .map((dir: { path: string }) => dir.path)
      .filter((dirPath: string) =>
        fs.existsSync(path.resolve(codeDir, dirPath))
      ),
  );
  for await (
    const componentDir of fs.walk(projectDir.path, {
      maxDepth: 1,
      includeFiles: false,
      includeDirs: true,
    })
  ) {
    if (projectDir.path === componentDir.path) continue;
    folders.add(path.relative(codeDir, componentDir.path));
  }
  workspaceContent.folders = [...folders].map((path: string) => ({ path }));

  log.info(`Updating ${workspacePath}`);
  await Deno.writeTextFile(workspacePath, JSON.stringify(workspaceContent));
}

export async function processCodeDir(codeDir: string) {
  log.info(`Looking in ${codeDir}`);
  for await (
    const projectDir of fs.walk(codeDir, {
      maxDepth: 1,
      includeFiles: false,
      includeDirs: true,
    })
  ) {
    if (projectDir.path === codeDir) continue;
    if (await isDevcontainer(projectDir.path)) {
      log.info(`Skipping ${projectDir.name} (.devcontainer exists)`);
      continue;
    }
    await processProjectDir(codeDir, projectDir);
  }
}

export async function main() {
  const codeDir = await ensureCodeDir();
  return processCodeDir(codeDir);
}

const cli = cac((import.meta.url.split("/").pop() ?? "").replace(".ts", ""));
cli.command("", "Synchronize Visual Studio Code workspaces").action(() => {
  return main();
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
