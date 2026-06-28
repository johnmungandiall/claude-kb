# Changelog — dated one-line history of notable KB / prompt changes.

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
