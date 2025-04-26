import {
  exec,
  OutputMode,
} from "https://raw.githubusercontent.com/gpasq/deno-exec/master/mod.ts";
import {
  basename,
  dirname,
  join,
} from "https://deno.land/std@0.129.0/path/mod.ts";

type os = "linux" | "darwin" | "windows";
export const isWin = (os = Deno.build.os) => os === "windows";

export const homeDirectoryEnv = (os?: os) => isWin(os) ? "USERPROFILE" : "HOME";
export const homeDirectory = (os?: os) =>
  Deno.env.get(homeDirectoryEnv(os)) ?? "/";

export const currentDirectory = () => basename(Deno.cwd());
export const parentDirectory = () => dirname(Deno.cwd());
export const siblingDirectories = async () => {
  const dirs = [];
  for await (const dirEntry of Deno.readDir(parentDirectory())) {
    if (dirEntry.isDirectory) {
      dirs.push(dirEntry.name);
    }
  }
  return dirs;
};
export const userEnv = (os?: os) => (isWin(os) ? "USERNAME" : "USER");
export const user = (os?: os) => Deno.env.get(userEnv(os)) ?? "/";
export const pathExists = async (path: string) => {
  try {
    await Deno.lstat(path);
    return true;
  } catch (_) {
    return false;
  }
};
export const windowsToWslPath = async (windowsPath: string) => {
  const wslPath = (
    await exec(`wslpath -u ${windowsPath}`, { output: OutputMode.Capture })
  ).output.trim();

  const home = homeDirectory();
  const winhome = join(home, "winhome");

  return wslPath.replace("~", winhome);
};

export const gitBranch = async (location = Deno.cwd()) => {
  return (
    await exec("git branch --show-current", {
      output: OutputMode.Capture,
      cwd: location,
    })
  ).output.trim();
};

export const gitTags = async (location = Deno.cwd()) => {
  return (
    await exec("git tag --points-at HEAD", {
      output: OutputMode.Capture,
      cwd: location,
    })
  ).output.trim();
};

export const executable = async (command: string) => {
  const checkCommand = isWin()
    ? `cmd /C "where ${command}"`
    : `sh -c "command -v ${command}"`;
  return (await exec(checkCommand, { output: OutputMode.None })).status.success;
};

export const editor = async (options = { wait: true }) => {
  if (await executable("code")) return ["code", "-r", options.wait ? "-w" : ""];
  if (await executable("code-insiders")) {
    return ["code-insiders", "-r", options.wait ? "-w" : ""];
  }
  if (await executable("io.elementary.code")) return ["io.elementary.code"];
  if (await executable("subl")) return ["subl", options.wait ? "-w" : ""];
  if (await executable("micro")) return ["micro"];
  return isWin() ? ["notepad"] : ["editor"];
};

export const invoke = (cmd: string[], options = {}) => {
  return Deno.run({ cmd, ...options }).status();
};

export const invokeOutputs = async (cmd: string[], options = {}) => {
  const pipe = Deno.run({ cmd, stderr: "piped", stdout: "piped", ...options });
  const [stdout, stderr] = await Promise.all([
    pipe.output(),
    pipe.stderrOutput(),
  ]);
  pipe.close();
  return [new TextDecoder().decode(stdout), new TextDecoder().decode(stderr)];
};

export const invokeOutput = async (cmd: string[], options = {}) => {
  const [stdout, _] = await invokeOutputs(cmd, options);
  return stdout.trim();
};

export const invokeShell = (shell: string[], cmd: string[], options = {}) => {
  const shellCommand = [...shell, cmd.join(" ")];

  return invoke(shellCommand, options);
};

export const fuzzyShell = async (
  shell: string[],
  query: string,
  cmd: string,
) => {
  const fzfCommand = query ? `fzf -1 -q ${query}` : "fzf -1";
  const process = Deno.run({
    cmd: [...shell, `${cmd} | ${fzfCommand}`],
    stdout: "piped",
  });
  await process.status();
  return new TextDecoder().decode(await process.output()).trimEnd();
};
export const fuzzy = (shell: string[], query: string, candidates: string[]) =>
  fuzzyShell(shell, query, `echo "${candidates.join('"\\n"')}"`);
