# Feature — slim prompt (`slim.md`)

- **Purpose:** Shrink an already-bloated `CLAUDE.md` — MOVE its reference/knowledge content into compact `kb/` notes (summary + `path:line`), leaving a one-line pointer in each spot. Focused migration only.
- **When:** `CLAUDE.md` got huge (loads every session, burns tokens) and the user wants it lean — without a full KB rebuild ([[prompt-init]]) or a drift audit ([[prompt-verify]]).
- **Linked from:** `README.md` links to `slim.md` (no embedded copy).

- **Incremental:** works ONE section at a time (note written + verified, THEN cut from `CLAUDE.md`); a 87K-token `CLAUDE.md` won't fit one pass, so if context runs low it STOPS at a clean boundary and reports DONE vs REMAIN (`slim.md:9-16`).

## What it does

| Step | Source | Action |
|------|--------|--------|
| 1 | `slim.md:19-29` | Read `CLAUDE.md`; sort into KEEP (always-on **+ safety-critical** directives) vs MOVE (reference) |
| 2 | `slim.md:30-36` | Distill each MOVE section into the matching `kb/` note — create if missing, MERGE if it already exists (no overwrite/dup) |
| 3 | `slim.md:37-39` | Verify NEW `path:line`s from real code; spot-check 2–3 pointers in an existing trusted note |
| 4 | `slim.md:40-42` | ONLY after the note is written + verified, cut the section from `CLAUDE.md` and leave a one-line pointer; loop |
| 5 | `slim.md:43-76` | Ensure lean `## Knowledge Base` block + `kb/about-kb.md` exist |
| 6 | `slim.md:77-78` | Bump "last indexed"; append `kb/changelog.md` entry |

## Rules

- Verify NEW `path:line`s from opened files (spot-check trusted notes); move (never delete); KEEP safety-critical directives even if conditional; never migrate secrets (`slim.md:80-91`).
- Output: size before/after + map of moved section → new note + (if stopped early) DONE vs REMAIN; report in the user's language (`slim.md:93-96`).

Overlaps STEP 5 of [[prompt-init]] / STEP 2 of [[prompt-update]], but standalone and single-purpose. Note rules in [[conventions]].
