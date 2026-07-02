# Runbook — edit a prompt without drift (shared blocks live in several prompts).

`README.md` only LINKS to the prompt files, so there is no README copy to sync.
But some blocks are DUPLICATED across the prompt files — touch one copy and the
rest drift silently. This note lists every artifact to update, in order. See
[[gotchas]] for the traps, [[conventions]] for note rules, [[cheatsheet]] for the check.

## Lockstep sets (edit one → update ALL)
- `about-kb` template — byte-identical in `prompt.md` + `update.md`.
- Lean `## Knowledge Base` block — in `prompt.md` + `update.md` + `slim.md`
  (`update.md`'s `<keep existing …>` map placeholders are the one allowed difference).
- `tools/kb-check.sh` — embedded in `prompt.md` + `update.md` + `check.md` (the bash block must equal the file).
- Version marker: `kb/overview.md` `last indexed vN` ↔ latest `kb/changelog.md` entry — keep N equal.

All four are checked MECHANICALLY by `bash tools/lockstep-check.sh` (also wired
into this repo's `.git/hooks/pre-commit`) — don't rely on this list from memory.

## Steps
1. Edit the standalone prompt file(s).
2. If you touched a shared block (above), apply the SAME edit to every prompt that embeds it —
   use `replace_all` for shared lines (or matching edits) so no copy diverges.
3. If a prompt's sections moved, refresh the line-number table in the matching `kb/features/` note.
4. Update any other `kb/` note whose underlying code/config changed.
5. Bump `kb/overview.md` last-indexed + version AND append a `kb/changelog.md` entry (same version — lockstep).
6. Run `bash tools/kb-check.sh` (until `broken 0`) AND `bash tools/lockstep-check.sh`
   (until "all sets in sync").
7. End the turn with a "KB: updated <notes>" status line.
