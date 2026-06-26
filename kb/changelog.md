# Changelog — dated one-line history of notable KB / prompt changes.

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
