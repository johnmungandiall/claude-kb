# Overview — reusable Claude Code prompt that bootstraps a self-maintaining `kb/` map for any repo.

- **What it is:** Markdown-only tooling — no runtime code. Users paste `prompt.md` into Claude Code on a target project.
- **Tech stack:** Markdown prompts + optional `CLAUDE.md` wiring in the target repo.
- **Entry points:** `prompt.md` (first-time setup), `update.md` (upgrade existing KB), `verify.md` (audit KB vs code), `slim.md` (shrink a bloated `CLAUDE.md`), `check.md` (install the drift checker), `hooks.md` (install Claude Code lifecycle hooks that auto-fire upkeep + the drift gate), `.claude/agents/` (KB subagents) + `tools/kb-check.sh` (drift checker), both auto-created by the prompts, `README.md` (human docs; links to the prompts).
- **How to use:** Open target project in Claude Code → paste `prompt.md` → Claude builds `kb/` and wires `CLAUDE.md`.
- **This repo:** The prompt templates themselves (meta — not a sample app).
- **See also:** [[architecture]] (layout + data flow), [[about-kb]] (full KB-maintenance rules — `CLAUDE.md` points here), [[prompt-init]] / [[prompt-update]] / [[prompt-verify]] / [[prompt-slim]] / [[prompt-check]] / [[prompt-hooks]] (the six prompts), [[kb-agents]] (the `.claude/agents/` subagents), [[about-you]] (user map), [[cheatsheet]], [[edit-a-prompt]] (edit runbook), [[gotchas]], [[changelog]], [[glossary]].
- **last indexed:** 2026-07-02 / v2.18 — full version history in [[changelog]] (single source of truth; not duplicated here).
