import * as path from "https://deno.land/std@0.109.0/path/mod.ts";

import { homeDirectory } from "../utils.ts";

const home = homeDirectory();
const winhome = path.join(home, "winhome");
const file = path.join(winhome, "OneDrive", "Essentials", "mem.ai.json");
const raw = await Deno.readTextFile(file);
const data = JSON.parse(raw);
type mem = { id: string; title: string; markdown: string };
data.forEach(async (mem: mem) => {
  const outputPath = path.join(
    winhome,
    "OneDrive",
    "Documents",
    "Appledore",
    "mem.ai",
    `${mem.id}.md`,
  );
  await Deno.writeTextFile(
    outputPath,
    `# ${mem.title}
--------
  ${mem.markdown}`,
  );
});
