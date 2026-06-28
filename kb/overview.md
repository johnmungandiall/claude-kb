# Overview — reusable Claude Code prompt that bootstraps a self-maintaining `kb/` map for any repo.

- **What it is:** Markdown-only tooling — no runtime code. Users paste `prompt.md` into Claude Code on a target project.
- **Tech stack:** Markdown prompts + optional `CLAUDE.md` wiring in the target repo.
- **Entry points:** `prompt.md` (first-time setup), `update.md` (upgrade existing KB), `verify.md` (audit KB vs code), `slim.md` (shrink a bloated `CLAUDE.md`), `.claude/agents/` (KB subagents, auto-created by the prompts), `README.md` (human docs + copy-paste blocks).
- **How to use:** Open target project in Claude Code → paste `prompt.md` → Claude builds `kb/` and wires `CLAUDE.md`.
- **This repo:** The prompt templates themselves (meta — not a sample app).
- **See also:** [[architecture]] (layout + data flow), [[prompt-init]] / [[prompt-update]] / [[prompt-verify]] / [[prompt-slim]] (the four prompts), [[kb-agents]] (the `.claude/agents/` subagents), [[about-you]] (user map), [[cheatsheet]], [[gotchas]], [[changelog]], [[glossary]].
- **version:** 2.6 — claude-kb now auto-creates KB subagents in `.claude/agents/` (`kb-maintainer`, `kb-verify`, `kb-slim`) so the KB maintains itself via auto-delegating agents in their own context. (v2.5: standalone `slim.md`. v2.4: init/upgrade auto-slim `CLAUDE.md`. v2.3: lean `CLAUDE.md` → `kb/about-kb.md`.)
- **last indexed:** 2026-06-27 / v2.6 KB subagents
