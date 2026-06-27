# Overview — reusable Claude Code prompt that bootstraps a self-maintaining `kb/` map for any repo.

- **What it is:** Markdown-only tooling — no runtime code. Users paste `prompt.md` into Claude Code on a target project.
- **Tech stack:** Markdown prompts + optional `CLAUDE.md` wiring in the target repo.
- **Entry points:** `prompt.md` (first-time setup), `update.md` (upgrade existing KB), `verify.md` (audit KB vs code), `slim.md` (shrink a bloated `CLAUDE.md`), `README.md` (human docs + copy-paste blocks).
- **How to use:** Open target project in Claude Code → paste `prompt.md` → Claude builds `kb/` and wires `CLAUDE.md`.
- **This repo:** The prompt templates themselves (meta — not a sample app).
- **See also:** [[architecture]] (layout + data flow), [[prompt-init]] / [[prompt-update]] / [[prompt-verify]] / [[prompt-slim]] (the four prompts), [[about-you]] (user map), [[cheatsheet]], [[gotchas]], [[changelog]], [[glossary]].
- **version:** 2.5 — new standalone `slim.md` prompt: shrink an already-bloated `CLAUDE.md` by migrating its reference content into `kb/` notes, leaving pointers (focused — no KB rebuild, no drift audit). (v2.4: init/upgrade prompts auto-slim `CLAUDE.md`. v2.3: wired `CLAUDE.md` made a LEAN pointer; full rules → `kb/about-kb.md`.)
- **last indexed:** 2026-06-27 / v2.5 slim.md prompt
