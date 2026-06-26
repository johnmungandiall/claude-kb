# Overview — reusable Claude Code prompt that bootstraps a self-maintaining `kb/` map for any repo.

- **What it is:** Markdown-only tooling — no runtime code. Users paste `prompt.md` into Claude Code on a target project.
- **Tech stack:** Markdown prompts + optional `CLAUDE.md` wiring in the target repo.
- **Entry points:** `prompt.md` (first-time setup), `update.md` (upgrade existing KB), `README.md` (human docs + copy-paste blocks).
- **How to use:** Open target project in Claude Code → paste `prompt.md` → Claude builds `kb/` and wires `CLAUDE.md`.
- **This repo:** The prompt templates themselves (meta — not a sample app).
- **See also:** [[architecture]] (layout + data flow), [[prompt-init]] / [[prompt-update]] (the two prompts), [[glossary]].
- **last indexed:** 2026-06-26 / verify + cross-link pass
