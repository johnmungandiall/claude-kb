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
