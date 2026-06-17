# claude-kb

A reusable **Claude Code** prompt that builds a compact, self-maintaining
knowledge base (`kb/`) for any repo. Future sessions read a small map instead of
the whole codebase — **fewer tokens, faster sessions.**

## Use it

1. Open your project in Claude Code.
2. Paste the prompt below (or the contents of [prompt.md](prompt.md)).
3. Claude reads the code, writes `kb/` notes, and wires your `CLAUDE.md` to read
   them first — then keeps them updated whenever the code changes.

## The prompt

````markdown
# ROLE
You maintain a COMPACT, token-efficient knowledge base (KB) for THIS project so
future AI sessions understand and navigate the codebase WITHOUT reading every file.

# GOAL
Create/update a small tree of Markdown notes under `kb/` that act as a MAP of the
project, AND wire the project's `CLAUDE.md` so the KB is SELF-MAINTAINING: once
wired, every future code change automatically refreshes the affected `kb/` notes
in the same session — the KB never goes stale. The KB must save tokens:
summarize, never copy code. Point to `path:line` instead of pasting code.

# STEPS
1. INVESTIGATE the code — do NOT skim. Read the entry points, config, and the key
   source files closely enough to understand what actually runs and how. Follow
   imports/calls to trace real data flow. Filenames and assumptions are NOT enough
   — open and read the file before you describe it. Writing KB notes from guesses
   instead of read code is the #1 failure; refuse to do it.
2. From what you ACTUALLY READ (never assumed), identify: architecture, main
   features/modules, key files + their responsibility, data models, state
   management, routing/navigation, external APIs/services, conventions, gotchas.
3. Write the KB as a TREE of tiny files:
   - `kb/overview.md`      — what it does, tech stack, entry point, how to run, "last indexed: <date/commit>"
   - `kb/architecture.md`  — module map + data flow (how pieces connect)
   - `kb/features/<name>.md`— one per major feature: purpose, key files as `path:line`, key functions
   - `kb/conventions.md`   — naming, folder rules, patterns used
   - `kb/glossary.md`      — domain/business terms
4. Update `CLAUDE.md` at the repo root (create it if missing). PRESERVE all existing
   content — only add/refresh a section named exactly `## Knowledge Base` containing:
   ```
   ## Knowledge Base (read FIRST — saves tokens)
   This repo has a compact KB in `kb/`. Before any task, read the relevant `kb/`
   files to orient instead of scanning the whole codebase.

   AUTO-MAINTAIN (mandatory): whenever you add, change, move, rename, or delete
   code/config in this repo, you MUST update the affected `kb/` note(s) in the
   SAME session, BEFORE ending your turn — treat it as part of "done", not
   optional. Touch only the notes whose underlying code changed; leave the rest.
   New major feature → add `kb/features/<name>.md`. Refresh the "last indexed"
   marker in `kb/overview.md`. Never let code and KB drift apart.

   Map of the KB:
   - kb/overview.md — <1-line>
   - kb/architecture.md — <1-line>
   - kb/features/ — <list feature notes>
   - kb/conventions.md, kb/glossary.md
   ```
   Fill the 1-line summaries from the actual files. Do not duplicate KB content into
   CLAUDE.md — link to it. Keep this section tight.

# RULES — keep it SMALL, DYNAMIC, ADVANCED
- ACCURACY over speed: every claim and every `path:line` must come from code you
  actually OPENED and verified this session — never from filenames or guesses.
  If you haven't read it, don't write it; go read it. Never invent files,
  functions, or line numbers. Verify a line number by looking at that line.
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
````

## License

[MIT](LICENSE).
