# Feature — verify prompt (`verify.md`)

- **Purpose:** Audit an existing KB for DRIFT against the code — re-check every `path:line`, fix cheap mismatches, report the rest. No rebuild.
- **When:** KB already exists and may be stale; user pastes `verify.md` (the third prompt, after `prompt.md` / `update.md`).
- **Also documented:** `README.md` "Verify prompt" section (embedded copy — keep in sync).

## What it does

| Step | Source | Action |
|------|--------|--------|
| 1 | `verify.md:7-12` | Run `tools/kb-check.sh` first, then read every note; open each referenced file to confirm the claim |
| 2 | `verify.md:13-19` | Classify drift: STALE / WRONG / MISSING / ORPHAN / BROKEN link |
| 3 | `verify.md:20-23` | Auto-fix cheap drift; leave bigger reworks for user confirmation |
| 4 | `verify.md:24-25` | Append `kb/changelog.md` entry; bump "last indexed" |

## Rules

- Verify before touching; incremental only; never invent line numbers; pointers = full path from root (`verify.md:27-33`).
- Output is two lists: FIXED and NEEDS-CONFIRMATION (`verify.md:34-36`).

Contrast with [[prompt-init]] (full build) and [[prompt-update]] (spec upgrade); note rules in [[conventions]].
