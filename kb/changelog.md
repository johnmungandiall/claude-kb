# Changelog — dated one-line history of notable KB / prompt changes.

- **2026-07-02 — v2.18:** DOGFOOD the v2.3 spec in THIS repo (gap reported by John):
  `kb/about-kb.md` never existed here — the full KB rules sat inline in `CLAUDE.md`
  (~80 lines) while `conventions`/`architecture`/`kb-maintainer` all described the
  lean-pointer layout. Created `kb/about-kb.md` from the canonical `prompt.md`
  template (+ a short "This repo" footer pointing at [[edit-a-prompt]] and
  `tools/lockstep-check.sh`) and rewrote `CLAUDE.md` as the lean block: triggers +
  map + pointer, ~40 lines. Prompts untouched; both checkers green. See [[about-kb]].
  Also: new `.gitattributes` pins `*.sh` / `tools/hooks/*` to LF so a fresh Windows
  clone (autocrlf) can't break the bash checkers. See [[gotchas]].
- **2026-07-02 — v2.17:** the LOCKSTEP SETS are now machine-checked, not
  discipline-checked (John's standing rule: automation over memory). New
  `tools/lockstep-check.sh` — repo-internal, NOT shipped/embedded — verifies all
  four sets mechanically: embedded `kb-check.sh` == `tools/kb-check.sh` in
  `prompt.md`/`update.md`/`check.md`, about-kb template byte-identical in
  `prompt.md`+`update.md`, lean `## Knowledge Base` block identical across
  `prompt.md`/`update.md`/`slim.md` (modulo `update.md`'s `<keep existing …>`
  placeholders), and `overview` version == newest `changelog` entry. Empty
  extraction = hard error (no silent pass when a marker moves — the v2.9/v2.13
  lesson). Verified: green on the current tree AND catches a seeded fault in each
  of the four sets. Wired into this repo's local `.git/hooks/pre-commit` (runs
  both checkers); shipped sample unchanged. Prompts untouched. See [[gotchas]],
  [[edit-a-prompt]], [[cheatsheet]].
- **2026-06-30 — v2.16:** added a standalone `hooks.md` prompt — a focused installer
  that drops two Claude Code lifecycle hooks into any repo and wires `.claude/settings.json`
  so the KB rules fire from the HARNESS, not just model discipline (requested by John):
  (1) `kb_update_reminder.py` (PostToolUse) nudges once per session to update the matching
  `kb/` note after a code/config edit; (2) `kb_drift_check.py` (Stop) runs
  `tools/kb-check.sh` and blocks the stop ONCE on broken pointers. Generalized from John's
  Qwantonomous-Engine hooks but kept FRAMEWORK-AGNOSTIC — the reminder uses a skip-list
  (`kb/`, `.claude/`, `.git/`, `node_modules/`, top-level docs), NO hardcoded language
  extensions. Scripts live embedded in `hooks.md` only (no dogfooded copy → no new lockstep
  gate); standalone like `check.md`, not wired into init/update. New
  `kb/features/prompt-hooks.md`; README "Get started" + `overview`/`architecture`/
  `conventions`/`cheatsheet` re-synced to six prompts. See [[prompt-hooks]], [[gotchas]].
- **2026-06-29 — v2.15:** simplified `README.md` and KILLED the prompt↔README lockstep
  set that keeps drifting (John's call). README no longer EMBEDS the five prompts —
  it just LINKS to the files (`prompt.md` / `update.md` / `slim.md` / `verify.md` /
  `check.md`) in a short "Get started" table; dropped every "What's new in vX" section
  (history lives only here) and trimmed filler so it stays simple/engaging. Re-synced
  the whole KB to the removal: `architecture`, `conventions`, `gotchas` (dropped the
  README-mirror traps; lockstep list now = about-kb template / lean block / embedded
  `kb-check.sh` / overview↔changelog), `cheatsheet` (removed the diff-gate + regen
  commands), `about-you`, all five `features/*`, `runbooks/edit-a-prompt`, and
  `CLAUDE.md`. See [[edit-a-prompt]], [[gotchas]].
- **2026-06-29 — v2.14:** bake anti-drift rules into the prompts (reported by John from
  real KB usage on a Flutter app where the version split across 3 files → wrong build),
  kept language/framework-agnostic: (1) LOCKSTEP SETS — a value/name/contract repeated in
  >1 place (version strings, a mirrored enum, a dup'd allowlist) must be edited everywhere
  + recorded as a KB invariant; (2) CENTRAL TRAPS — a feature-note trap also gets a stub in
  `kb/gotchas.md`; (3) RUNBOOKS — multi-step procedures get a `kb/runbooks/<name>.md` (every
  artifact, in order); (4) VISIBLE UPKEEP — end a code/config change with a "KB: updated
  <note>" status line. Added to the about-kb template + lean `## Knowledge Base` block +
  `prompt.md` STEP 3 tree/RULES (all five README copies re-synced). ALSO fixed a real
  lockstep drift this surfaced: README's embedded prompt blocks had been stale since v2.13
  (the prose was never re-synced) — regenerated all five from the standalone files (diff
  gate green) and added the regenerate command to [[cheatsheet]]. New
  `kb/runbooks/edit-a-prompt.md`; feature-note line tables refreshed. See [[gotchas]], [[edit-a-prompt]].
- **2026-06-28 — v2.13:** the checker is now SYMBOL-AWARE and can AUTO-FIX. Root
  cause (reported by John): the prior tool only saw backtick `path:line` and
  un-backticked `name():line`, so the dominant **name-anchored** style — `` `Name`:line ``
  / `` `name()`:line `` with the file given by a same-line link (colon OUTSIDE the
  backticks) — slipped through silently → false "OK" while real pointers drifted.
  Rewrote `tools/kb-check.sh` (single awk pass + per-record check): (1) binds a
  name-anchored pointer to its file via a same-line md-link, a `(basename.ext)` hint,
  or the note's **primary file** (first link); (2) STALE = the named symbol isn't on
  the cited line (catches in-range drift); (3) `--fix` rewrites a drifted `:line` from
  the symbol's unique definition (excludes calls/comments); (4) markdown-link &
  backtick-path stay hard errors. Coverage on a real KB went 5→54 checked. Wired
  `--fix` into `prompt.md` / `update.md` / `check.md` / `verify.md` (run `--fix`, then
  a plain check until `broken 0`); re-synced all embedded copies (3× in README) and
  the "Pointers & freshness" rule (prefer name-anchored; illustrative examples use a
  `<line>` placeholder so the checker skips them). See [[gotchas]].
- **2026-06-27 — v2.12:** the checker now RESOLVES note-relative paths, not just
  root-relative — so it actually verifies pointers written as markdown links
  (`](../../lib/...):69`), checking the file + line range instead of just rejecting
  the form (reported by John: the tool was effectively seeing ~1 of 30+ real
  pointers). Verified on a mixed-form fixture (valid link `:69` passes; out-of-range,
  missing file, and pathless `name():line` all caught). Pointer rule reconciled to
  accept root- OR note-relative paths; all embedded copies + `tools/kb-check.sh`
  re-synced (embedded == file gate).
- **2026-06-27 — v2.11:** added a standalone `check.md` prompt — a focused,
  can't-skip installer that creates `tools/kb-check.sh` + the sample hook and runs
  it, for repos whose KB predates the checker (or that just want the drift gate)
  without a full init/update. New `kb/features/prompt-check.md`; mirrored into
  README; embedded script == `tools/kb-check.sh` (gate). Now five prompts.
- **2026-06-27 — v2.10:** FIX — agents running `update.md` (and `prompt.md`) were
  SKIPPING the create-`tools/kb-check.sh` step (a long, late, "if missing" step), so
  the checker never landed in target repos (reported by John). Made it a verified
  completion gate: OUTPUT now requires RUNNING `bash tools/kb-check.sh` before
  reporting done — the command fails if the file is missing, forcing creation. Can't
  be silently skipped anymore.
- **2026-06-27 — v2.9:** FIX — `tools/kb-check.sh` only matched the backtick
  `path:line` form, so it silently ignored markdown-link (`](path):line`),
  stray-paren (`path):line`) and function-form (`name():line`) pointers — it could
  report "OK" while checking almost nothing (reported by John). The checker now
  sees every form: resolves backtick / link / stray-paren paths (must be a full
  path from the repo root) and flags pathless `name():line` refs as uncheckable.
  Verified against a mixed-form fixture. Embedded copies in `prompt.md` / `update.md`
  / README updated to match. Also: illustrative pointer examples (e.g. in the
  about-kb template) now read "`path` at line N" so the broadened matcher doesn't
  false-fail on them in fresh target repos.
- **2026-06-27 — v2.8:** actually SHIP the automation — the prompts now auto-create
  `tools/kb-check.sh` AND a sample `tools/hooks/pre-commit` in any target repo
  (`prompt.md` STEP 7, `update.md` step 8), so the checker the rules reference really
  exists everywhere, not just in docs. about-kb wording corrected ("created by the
  setup", not "claude-kb ships"). Reported by John (audit found the script promised
  but missing in target repos).
- **2026-06-27 — v2.7:** shift KB maintenance from discipline to AUTOMATION — new
  `tools/kb-check.sh` resolves every `path:line` pointer (file exists + line in
  range) and, with `--freshness`, flags notes older than the code they cite (git).
  New rules: pointers are a FULL path from repo root + `:line` (script-checkable),
  the function/class NAME is the durable anchor (line is a hint), and release
  history lives ONLY in `kb/changelog.md` (`overview.md` keeps a one-line
  last-indexed). `verify.md` + the `kb-verify` agent now run the checker first.
- **2026-06-27 — v2.6:** the prompts now AUTO-CREATE KB subagents under
  `.claude/agents/` (`kb-maintainer`, `kb-verify`, `kb-slim`) so the KB maintains
  ITSELF via auto-delegating agents in their own context window. `prompt.md` STEP 6
  + `update.md` step 7 write them; about-kb "Sub-agents" rule prefers delegating to
  them. New `kb/features/kb-agents.md`; reference copies live in this repo's
  `.claude/agents/`. README prompt/update blocks mirrored. Also added a condensed
  "How to work" discipline (think-first, simplest, surgical, goal-driven) to the
  about-kb template and to each agent body.
- **2026-06-27 — v2.5:** added a standalone `slim.md` prompt — a focused job that
  migrates reference content out of an already-bloated `CLAUDE.md` into `kb/` notes
  and leaves pointers, without rebuilding the KB or auditing for drift. Hardened for
  big files: works ONE section at a time (stop-at-boundary on low context), KEEPs
  safety-critical directives even when conditional, MERGEs into existing notes
  instead of overwriting. Mirrored into `README.md`; new `kb/features/prompt-slim.md`.
- **2026-06-27 — v2.4:** the init/upgrade prompts now SLIM the target `CLAUDE.md` —
  migrate reference content (architecture, commands, config, conventions, gotchas)
  out of `CLAUDE.md` into the matching `kb/` note (condensed + `path:line`), leaving
  a one-line pointer. Paste the prompt in ANY repo to shrink a bloated `CLAUDE.md`.
- **2026-06-26 — v2.3:** moved the full KB-maintenance / sub-agent / user-map rules
  out of the wired `CLAUDE.md` into a new `kb/about-kb.md`; `CLAUDE.md` now carries
  only short triggers + map + a pointer (loads detail on demand). `prompt.md` split
  into STEP 4 (create about-kb) + STEP 5 (lean block); `update.md` migrates in place.
- **2026-06-26 — v2.2:** added rule-level features (last-verified marker, mermaid
  in architecture, global user prefs, secret guard, size-guard split); new optional
  notes `gotchas` / `changelog` / `cheatsheet`; new `verify.md` drift-audit prompt.
- **2026-06-26 — v2.1:** added `kb/about-you.md` — the KB now also maps the USER
  (working style, tech, goals, rules) and self-evolves.
- **2026-06-26 — v2.0:** enforced `[[cross-link]]`s as a first-class rule and a
  MANDATORY "read the KB FIRST" directive in the `CLAUDE.md` template.

See [[overview]] for the current version, [[conventions]] for note rules.
