# Feature — slim prompt (`slim.md`)

- **Purpose:** Shrink an already-bloated `CLAUDE.md` — MOVE its reference/knowledge content into compact `kb/` notes (summary + `path:line`), leaving a one-line pointer in each spot. Focused migration only.
- **When:** `CLAUDE.md` got huge (loads every session, burns tokens) and the user wants it lean — without a full KB rebuild ([[prompt-init]]) or a drift audit ([[prompt-verify]]).
- **Also documented:** `README.md` "Slim prompt" section (embedded copy — keep byte-identical, see [[conventions]]).

## What it does

| Step | Source | Action |
|------|--------|--------|
| 1 | `slim.md:10-17` | Read `CLAUDE.md`; sort content into KEEP (always-on directives) vs MOVE (reference) |
| 2 | `slim.md:18-23` | Distill each MOVE section into the matching `kb/` note, ≤50 lines, verify `path:line` from real code |
| 3 | `slim.md:24-25` | Replace the moved section in `CLAUDE.md` with a one-line pointer |
| 4 | `slim.md:26-55` | Ensure lean `## Knowledge Base` block + `kb/about-kb.md` exist |
| 5 | `slim.md:56-57` | Bump "last indexed"; append `kb/changelog.md` entry |

## Rules

- Verify `path:line` from opened files; move (never delete); never migrate secrets (`slim.md:59-67`).
- Output: `CLAUDE.md` size before/after + a map of each moved section → its new note (`slim.md:69-71`).

Overlaps STEP 5 of [[prompt-init]] / STEP 2 of [[prompt-update]], but standalone and single-purpose. Note rules in [[conventions]].
