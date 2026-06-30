# Conventions — how claude-kb prompts and KB notes are structured.

## Prompt files

- **`prompt.md`** — full init; use on projects with no KB yet.
- **`update.md`** — delta upgrade; use when KB already exists.
- **`verify.md`** — audit existing KB for drift vs code; fix cheap, report rest. See [[prompt-verify]].
- **`slim.md`** — shrink a bloated `CLAUDE.md`; migrate reference content into `kb/`, leave pointers. See [[prompt-slim]].
- **`check.md`** — install `tools/kb-check.sh` + sample hook in any repo (focused, can't-skip). See [[prompt-check]].
- **`hooks.md`** — install Claude Code lifecycle hooks (`.claude/hooks/*.py` + `settings.json`) that auto-fire KB upkeep + the drift gate (focused). See [[prompt-hooks]].
- **`README.md`** — human-facing intro; LINKS to the prompt files (no embedded copies to sync).
- **`.claude/agents/`** — KB subagents the prompts auto-create (`kb-maintainer`, `kb-verify`, `kb-slim`); distilled, NOT byte-synced to the prompts (generated artifacts). See [[kb-agents]].

## KB note rules (enforced in prompts)

- Each file ≤ 50 lines; bullets/tables; no code dumps.
- Reference code as a `path:line` the checker can resolve — a full path from the repo root (preferred) or one relative to the note (markdown links work), verified by reading the file; no bare filenames or `name()` refs without a path, so `tools/kb-check.sh` can verify it. Name the function/class too: the NAME is the durable anchor, the line a hint that may drift (grep the name if it's off).
- Release history lives ONLY in `kb/changelog.md`; `kb/overview.md` keeps a one-line `last indexed: <date>`, nothing more — no duplication.
- Don't rely on memory — run `bash tools/kb-check.sh` (resolves every pointer; `--freshness` flags git-stale notes) before release or on a pre-commit hook. See [[cheatsheet]].
- One fact per place; cross-link with `[[other-note]]`.
- NO SILENT DRIFT: a value/name/contract repeated in >1 place is a "lockstep set" —
  edit one member, search the old value to zero, and record it as an invariant
  ("change X → also Y, Z") cross-linked to each member. See [[edit-a-prompt]].
- A trap noted in a feature/module note ALSO gets a one-line stub + `[[gotchas]]` link
  in the central `kb/gotchas.md` index, or it won't be found.
- Multi-step procedures (release, deploy, secret rotation, onboarding) get a
  `kb/runbooks/<name>.md` listing EVERY file/step/artifact in order — not just commands.
- Visible upkeep: end any code/config change with a "KB: updated <note>" / "no change
  needed because <reason>" status line.
- Start each file with a one-line summary.
- `kb/about-you.md` maps the USER (style, tech, goals, rules), not code; tag items [confirmed]/[inferred]. See [[glossary]].
- `CLAUDE.md` is a LEAN pointer — short triggers + map + a link to `kb/about-kb.md`; the full maintenance rules live in that note, never inline.

## Target `CLAUDE.md` section

- Exact heading: `## Knowledge Base` (optionally suffixed `(read FIRST — saves tokens)` per template).
- Body is LEAN: short triggers (read-first; after-change → update `kb/`; user-pref → `about-you`; sub-agents) + the map + a pointer to `kb/about-kb.md`. The full rules live in that note, not inline — keeps every session cheap.
- Map lists each `kb/` file with a 1-line description; update map line only when files added/removed.

See [[prompt-init]] / [[prompt-update]] for how these rules are enforced; [[architecture]] for the file tree.
