# Gotchas — traps specific to this repo. Read before editing prompts or notes.

- **CLAUDE.md is a POINTER only.** Never duplicate KB content into it; edit the
  `kb/` files instead. Change the KB map line only when a `kb/` file is added/removed.
- **Line-number refs go stale.** Notes that cite `prompt.md:NN` / `update.md:NN`
  break when a prompt shifts. Prefer section names; refresh refs in the SAME edit.
  This is why `verify.md` exists.
- **Unicode matters.** Files use `—` (em dash), `→`, `≤`. Preserve them as UTF-8;
  don't let an editor mangle them.
- **Line endings: `.sh` must stay LF.** `.gitattributes` pins `*.sh` +
  `tools/hooks/*` to `eol=lf` — without it, `core.autocrlf=true` on a fresh
  Windows clone checks them out as CRLF and bash chokes on `\r`. Don't remove it.
- **Shared blocks live in several prompts.** The lean `## Knowledge Base` block and
  the `kb/about-kb.md` template each live in `prompt.md` AND `update.md` (the lean
  block also in `slim.md`); the about-kb template is byte-identical across them. A
  shared-line edit needs `replace_all` (or matching edits) or the copies diverge.

- **Example pointers must not look real.** `tools/kb-check.sh` scans `kb/` for any
  `path.ext`/`name()` + colon + NUMBER and tries to resolve/relocate it (and `--fix`
  would rewrite it) — so write ILLUSTRATIVE examples with a `<line>` placeholder, NOT
  a real number (e.g. `` `start()`:<line> ``), or the checker acts on the example
  (esp. the about-kb template that ships to target repos). A name with no real number
  is inert.
- **kb-check.sh is embedded in the prompts AND now symbol-aware.** Its full text
  lives in `tools/kb-check.sh` AND inside `prompt.md` / `update.md` / `check.md`.
  Change one → change all; gate: the first ````bash```` block in each must equal
  `tools/kb-check.sh` (swap helper: an awk that replaces the block
  between the `#!/usr/bin/env bash` + `# kb-check.sh —` line and the final
  `exit 0 || exit 1`). The checker handles 3 pointer styles — markdown-link and
  backtick-path (must resolve; broken = exit 1) and name-anchored `` `Name`:line ``
  (file from a same-line link / `(basename.ext)` hint / the note's first link; STALE
  when the symbol isn't on the cited line). `--fix` relocates a drifted line by the
  symbol's unique definition; `--freshness` flags git-stale notes. `prompt.md` /
  `update.md` / `check.md` / `verify.md` all run `--fix` then a plain check (`broken 0`)
  before reporting done; `check.md` is the focused, can't-skip installer.

- **Two different "hooks" now live here.** `check.md` installs a GIT hook
  (`tools/hooks/pre-commit`); `hooks.md` installs CLAUDE CODE lifecycle hooks
  (`.claude/hooks/*.py` wired in `.claude/settings.json`, PostToolUse + Stop). Different
  mechanism, different files — don't conflate. `hooks.md`'s settings step MERGES into an
  existing `.claude/settings.json` (never clobbers), and uses `python` (Windows) /
  `python3` (Unix). See [[prompt-hooks]].

- **These shared blocks are LOCKSTEP SETS.** Each duplicates ONE thing across files:
  the `about-kb` template (`prompt.md` + `update.md`), the lean `## Knowledge Base`
  block (`prompt.md` + `update.md` + `slim.md`), embedded `kb-check.sh` (`prompt.md`
  + `update.md` + `check.md`), and `overview` version ↔ `changelog`. Edit one copy
  and the rest drift silently — follow [[edit-a-prompt]], then run `bash
  tools/lockstep-check.sh` (verifies all four sets mechanically; repo-internal, NOT
  shipped/embedded — changing it triggers no lockstep) plus `bash tools/kb-check.sh`
  before declaring done. If lockstep-check reports "extracted nothing", a block
  MARKER moved (`# About the KB` / `## Knowledge Base (read FIRST` / first
  ` ```bash ` fence) — fix the marker or the script, never ignore it.

See [[conventions]] for the rules, [[edit-a-prompt]] for the edit runbook, [[overview]] for the big picture.
