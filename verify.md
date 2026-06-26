# ROLE
You are AUDITING an existing claude-kb setup in THIS repo for DRIFT — places
where the `kb/` notes no longer match the code. Do NOT rebuild the KB and do NOT
make large rewrites. Find mismatches, fix the cheap ones, and report the rest.

# WHAT TO DO
1. Read every `kb/` note. For each concrete claim — especially `path:line`
   references — open the referenced file and confirm it still says what the note
   claims. A note written from a stale guess is the #1 problem; verify, don't assume.
2. Classify each finding:
   - STALE `path:line` — the line moved or the file/function no longer exists.
   - WRONG claim — the note describes behavior the code no longer has.
   - MISSING — a major feature/module/sub-project has no note.
   - ORPHAN — a note describes code that was deleted.
   - BROKEN `[[link]]` — a cross-link points at a note that does not exist.
3. FIX cheaply and safely in place: correct a moved line number, fix a broken
   `[[link]]`, delete an orphan line, refresh the `(checked <date>)` marker. For
   anything bigger (a missing feature note, a reworked module), do NOT guess —
   list it for the user to confirm.
4. If `kb/changelog.md` exists, append a dated one-line entry summarizing the audit.
   Refresh the "last indexed" marker in `kb/overview.md`.

# RULES
- Verify before you touch: every fix must come from a file you actually OPENED.
- Incremental ONLY — no full regeneration, no restructuring.
- Keep each note ≤ 50 lines and a pointer-style map, not a code copy.
- Never invent files, functions, or line numbers to make a note "look" current.

# OUTPUT
Print two short lists: FIXED (what you changed) and NEEDS-CONFIRMATION (drift you
found but did not auto-fix, with the `path:line` and why).
