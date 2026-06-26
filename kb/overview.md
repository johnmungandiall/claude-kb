# Overview — reusable Claude Code prompt that bootstraps a self-maintaining `kb/` map for any repo.

- **What it is:** Markdown-only tooling — no runtime code. Users paste `prompt.md` into Claude Code on a target project.
- **Tech stack:** Markdown prompts + optional `CLAUDE.md` wiring in the target repo.
- **Entry points:** `prompt.md` (first-time setup), `update.md` (upgrade existing KB), `verify.md` (audit KB vs code), `README.md` (human docs + copy-paste blocks).
- **How to use:** Open target project in Claude Code → paste `prompt.md` → Claude builds `kb/` and wires `CLAUDE.md`.
- **This repo:** The prompt templates themselves (meta — not a sample app).
- **See also:** [[architecture]] (layout + data flow), [[prompt-init]] / [[prompt-update]] / [[prompt-verify]] (the three prompts), [[about-you]] (user map), [[cheatsheet]], [[gotchas]], [[changelog]], [[glossary]].
- **version:** 2.2 — adds last-verified markers, mermaid, global user prefs, secret guard, size-split rule; optional `gotchas`/`changelog`/`cheatsheet` notes; and `verify.md` drift audit.
- **last indexed:** 2026-06-26 / v2.2 feature batch
