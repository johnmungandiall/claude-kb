# claude-kb

A single, reusable prompt for **Claude Code** that turns it into a
**token-saving knowledge-base builder** for your project.

Run it once and Claude Code scans your repo and writes a compact tree of Markdown
notes under `kb/` — a *map* of the codebase — then wires your `CLAUDE.md` to read
that map first. Future sessions orient from the KB instead of re-reading every
file, so each task starts cheaper.

## Why it's faster & cheaper

The KB is mainly a **token saver**, and that makes sessions **faster** as a side
effect:

- **Smaller context → quicker responses.** Claude reads a few tiny `kb/` notes
  instead of scanning many files, so there's far less to process before it
  starts answering.
- **Fewer round-trips.** The KB is a *map*, so Claude jumps straight to the right
  `path:line` instead of searching and re-reading. Fewer tool calls = less
  waiting.
- **Lower cost per task.** Fewer input tokens on every session.

It doesn't change Claude's raw generation speed — the win comes from giving it
*less to read and less to hunt for*. The benefit grows with codebase size, and
only holds while the KB stays accurate (which is why it's
[self-maintaining](#self-maintaining)).

## What's in this repo

| File | Purpose |
|------|---------|
| [prompt.md](prompt.md) | The prompt to give Claude Code. |
| [LICENSE](LICENSE) | MIT. |

## Usage

1. Open the project you want indexed in Claude Code.
2. Paste the full contents of [prompt.md](prompt.md) as your instruction.
3. Claude Code scans the repo and produces:
   - `kb/overview.md` — what it does, stack, entry point, how to run, last-indexed marker
   - `kb/architecture.md` — module map + data flow
   - `kb/features/<name>.md` — one tiny note per major feature
   - `kb/conventions.md` — naming, folder rules, patterns
   - `kb/glossary.md` — domain terms
   - a `## Knowledge Base` section added to your repo's `CLAUDE.md` that points
     at the KB (existing `CLAUDE.md` content is preserved).

Tip: drop `prompt.md` into the project and reference it instead of pasting:

```
> use the instructions in prompt.md to build/refresh the KB for this repo
```

## The prompt

The full contents of [prompt.md](prompt.md) — copy and paste this into Claude Code:

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

## Self-maintaining

The wiring added to `CLAUDE.md` makes the KB **auto-update**: once it's in place,
whenever Claude Code adds, changes, renames, or deletes code in the repo it must
refresh the affected `kb/` note(s) in the **same session** — keeping code and KB
in sync without you asking. New major features get their own
`kb/features/<name>.md`, and `kb/overview.md`'s "last indexed" marker is bumped.

You can still re-run [prompt.md](prompt.md) manually any time for a full pass; it
updates **only** the sections whose underlying code changed and leaves the rest
untouched.

## Design principles

- **Summarize, never copy.** Notes reference code as `path/to/file.ext:42`, not
  by pasting it.
- **Small and dense.** Each KB file is ≤ 50 lines — bullets and tables, no prose
  padding.
- **Capture the *why*.** Only what a filename doesn't already reveal: intent and
  the wiring between parts.
- **`CLAUDE.md` stays a pointer**, never a copy of the KB — that's what keeps
  every session cheap.

## License

[MIT](LICENSE) — use it freely; just keep the copyright notice.
