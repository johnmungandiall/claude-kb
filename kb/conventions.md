# Conventions — how claude-kb prompts and KB notes are structured.

## Prompt files

- **`prompt.md`** — full init; use on projects with no KB yet.
- **`update.md`** — delta upgrade; use when KB already exists.
- **`README.md`** — duplicates both prompts in fenced blocks for GitHub browsing; keep in sync with standalone files.

## KB note rules (enforced in prompts)

- Each file ≤ 50 lines; bullets/tables; no code dumps.
- Reference code as `path:line`, verified by reading the file.
- One fact per place; cross-link with `[[other-note]]`.
- Start each file with a one-line summary.
- `CLAUDE.md` is a pointer only — never duplicate KB content there.

## Target `CLAUDE.md` section

- Exact heading: `## Knowledge Base` (optionally suffixed `(read FIRST — saves tokens)` per template).
- Map lists each `kb/` file with a 1-line description; update map line only when files added/removed.

See [[prompt-init]] / [[prompt-update]] for how these rules are enforced; [[architecture]] for the file tree.
