# Gotchas — traps specific to this repo. Read before editing prompts or notes.

- **README mirrors all 5 prompts.** `README.md` embeds the full text of
  `prompt.md`, `update.md`, `verify.md`, `slim.md`, `check.md` in ````markdown
  blocks. Edit a prompt → mirror into its block, or they drift. Verify with the diff gate (see [[cheatsheet]]).
- **CLAUDE.md is a POINTER only.** Never duplicate KB content into it; edit the
  `kb/` files instead. Change the KB map line only when a `kb/` file is added/removed.
- **Line-number refs go stale.** Notes/CLAUDE.md that cite `README.md:NN` or
  `update.md:NN` break when a prompt shifts. Prefer section names; refresh refs in
  the SAME edit. This is why `verify.md` exists.
- **Unicode matters.** Files use `—` (em dash), `→`, `≤`. Preserve them as UTF-8;
  don't let an editor mangle them.
- **Embedded prompt copies in README.** The lean `## Knowledge Base` block and the
  `kb/about-kb.md` template each live in `prompt.md` AND `update.md`, mirrored again
  in README — the about-kb template is byte-identical across all four. A shared-line
  edit needs `replace_all` (or matching edits) or the copies diverge.

- **Example pointers must not look real.** `tools/kb-check.sh` scans `kb/` for any
  `path.ext`/`name()` + colon + NUMBER and tries to resolve/relocate it (and `--fix`
  would rewrite it) — so write ILLUSTRATIVE examples with a `<line>` placeholder, NOT
  a real number (e.g. `` `start()`:<line> ``), or the checker acts on the example
  (esp. the about-kb template that ships to target repos). A name with no real number
  is inert.
- **kb-check.sh is embedded in the prompts AND now symbol-aware.** Its full text
  lives in `tools/kb-check.sh` AND inside `prompt.md` / `update.md` / `check.md`
  (mirrored 3× in README). Change one → change all; gate: the first ````bash```` block
  in each must equal `tools/kb-check.sh` (swap helper: an awk that replaces the block
  between the `#!/usr/bin/env bash` + `# kb-check.sh —` line and the final
  `exit 0 || exit 1`). The checker handles 3 pointer styles — markdown-link and
  backtick-path (must resolve; broken = exit 1) and name-anchored `` `Name`:line ``
  (file from a same-line link / `(basename.ext)` hint / the note's first link; STALE
  when the symbol isn't on the cited line). `--fix` relocates a drifted line by the
  symbol's unique definition; `--freshness` flags git-stale notes. `prompt.md` /
  `update.md` / `check.md` / `verify.md` all run `--fix` then a plain check (`broken 0`)
  before reporting done; `check.md` is the focused, can't-skip installer.

See [[conventions]] for the rules, [[overview]] for the big picture.
