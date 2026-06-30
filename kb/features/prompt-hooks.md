# Feature — hooks prompt (`hooks.md`)

- **Purpose:** Install Claude Code lifecycle hooks in any repo so the KB-maintenance
  rules fire AUTOMATICALLY instead of relying on the model to remember them. Focused,
  single-purpose (like [[prompt-check]]) — creates two hook scripts + wires
  `.claude/settings.json`; no KB rebuild, no audit.
- **When:** A repo that already has the KB rules but wants them ENFORCED by the harness
  (the model still skips upkeep sometimes). Complements `tools/kb-check.sh` (the script)
  by triggering it on the `Stop` event.
- **Linked from:** `README.md` links to `hooks.md` (no embedded copy).

## What it does

| Step | Source | Action |
|------|--------|--------|
| 1 | hooks.md "WHAT TO DO" step 1 | Create `.claude/hooks/kb_update_reminder.py` verbatim (PostToolUse) |
| 2 | hooks.md "WHAT TO DO" step 2 | Create `.claude/hooks/kb_drift_check.py` verbatim (Stop) |
| 3 | hooks.md "WHAT TO DO" step 3 | MERGE the `hooks` block into `.claude/settings.json` (never clobber) |
| 4 | hooks.md "WHAT TO DO" step 4 | Tell the user how each hook behaves + how to disable |

## The two hooks

- **`kb_update_reminder.py`** — PostToolUse (Edit|Write|MultiEdit). Once per session,
  after an edit OUTSIDE `kb/`, `.claude/`, `.git/`, `node_modules/` and the top-level
  docs, injects a non-blocking reminder to update the matching `kb/` note. Framework-
  agnostic — skip-list based, NO hardcoded language extensions (the example it was
  generalized from filtered `.dart`/`.ts`/Supabase dirs; that was dropped).
- **`kb_drift_check.py`** — Stop hook. Runs `bash tools/kb-check.sh`; if it exits
  non-zero, blocks the stop ONCE (`stop_hook_active` guard) and feeds the drift back.
  No-op when `tools/kb-check.sh` is absent or on any tooling error (never traps the user).

## Rules & output

- Focused: only the two `.claude/hooks/*.py` files + the `.claude/settings.json` wiring;
  scripts written byte-for-byte; settings MERGED, not overwritten (see `hooks.md` RULES).
- Prereqs: Python 3 (`python` on Windows, `python3` on macOS/Linux) + `bash` for the
  Stop hook. Output reports the files created and which `python` form was wired.

## Notes

- Standalone installer, NOT wired into [[prompt-init]] / [[prompt-update]] — same
  "separate focused prompt" pattern as [[prompt-check]]. The scripts live ONLY embedded
  in `hooks.md` (no dogfooded copy in this repo, so no new lockstep gate).
- These are Claude Code lifecycle hooks (`.claude/settings.json`) — distinct from the
  git `tools/hooks/pre-commit` that [[prompt-check]] installs. See [[gotchas]].
