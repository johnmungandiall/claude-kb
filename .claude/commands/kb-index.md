<!--
SPDX-License-Identifier: AGPL-3.0-only
Part of claude-kb — https://github.com/qwantonomous/claude-kb
Copyright (C) 2026 claude-kb contributors
This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License v3.0 as published by the
Free Software Foundation. See the LICENSE file for the full text.
-->
---
description: Build/refresh a compact, token-saving knowledge base (kb/) for this project and wire CLAUDE.md to use it.
argument-hint: "[optional: feature or path to (re)index]"
---

# ROLE
You maintain a COMPACT, token-efficient knowledge base (KB) for THIS project so
future AI sessions understand and navigate the codebase WITHOUT reading every file.

# GOAL
Create/update a small tree of Markdown notes under `kb/` that act as a MAP of the
project, AND wire the project's `CLAUDE.md` to use that KB. The KB must save tokens:
summarize, never copy code. Point to `path:line` instead of pasting code.

# SCOPE
- If `$ARGUMENTS` is provided, only (re)index that feature/path and its `kb/` note(s);
  leave all other KB files untouched.
- Otherwise, index the whole repo (first run) or incrementally refresh only the
  sections whose underlying code changed since "last indexed" (re-run).

# STEPS
1. Scan the repo: entry points, folder structure, config, dependencies, build/run.
2. Identify: architecture, main features/modules, key files + their responsibility,
   data models, state management, routing/navigation, external APIs/services,
   conventions, gotchas.
3. Write the KB as a TREE of tiny files:
   - `kb/overview.md`       — what it does, tech stack, entry point, how to run, "last indexed: <date/commit>"
   - `kb/architecture.md`   — module map + data flow (how pieces connect)
   - `kb/features/<name>.md` — one per major feature: purpose, key files as `path:line`, key functions
   - `kb/conventions.md`    — naming, folder rules, patterns used
   - `kb/glossary.md`       — domain/business terms
4. Update `CLAUDE.md` at the repo root (create it if missing). PRESERVE all existing
   content — only add/refresh a section named exactly `## Knowledge Base` containing:
   ```
   ## Knowledge Base (read FIRST — saves tokens)
   This repo has a compact KB in `kb/`. Before any task, read the relevant `kb/`
   files to orient instead of scanning the whole codebase. After changing code,
   update the affected `kb/` file(s) in the SAME session. Map of the KB:
   - kb/overview.md — <1-line>
   - kb/architecture.md — <1-line>
   - kb/features/ — <list feature notes>
   - kb/conventions.md, kb/glossary.md
   ```
   Fill the 1-line summaries from the actual files. Do not duplicate KB content into
   CLAUDE.md — link to it. Keep this section under 15 lines.

# RULES — keep it SMALL, DYNAMIC, ADVANCED
- Each KB file ≤ 50 lines. Dense bullets and tables only. No prose padding. No full code dumps.
- Reference code as `lib/auth/login_service.dart:42`, NOT by pasting it.
- Capture only what a filename does NOT reveal — the "why" and the wiring between parts.
- Keep a STABLE structure so it can be regenerated incrementally: on re-run, update
  ONLY the sections whose underlying code changed; leave the rest untouched.
- One fact per place; link related notes with `[[other-note]]`.
- Optimize for retrieval: start each file with a one-line summary of its contents.
- CLAUDE.md stays a POINTER to `kb/`, never a copy of it (keeps every session cheap).

# OUTPUT
Create/update the files under `kb/`, update the `## Knowledge Base` section in
`CLAUDE.md`, then print a short list of what changed.
