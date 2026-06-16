# claude-kb

A single, reusable prompt for **Claude Code** that turns it into a
**token-saving knowledge-base builder** for your project.

Run it once and Claude Code scans your repo and writes a compact tree of Markdown
notes under `kb/` — a *map* of the codebase — then wires your `CLAUDE.md` to read
that map first. Future sessions orient from the KB instead of re-reading every
file, so each task starts cheaper.

## What's in this repo

| File | Purpose |
|------|---------|
| [prompt.md](prompt.md) | The prompt to give Claude Code. |
| [LICENSE](LICENSE) | AGPL-3.0. |

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

## Re-running (incremental updates)

The prompt is built to be re-run. On a second pass Claude Code updates **only**
the KB sections whose underlying code changed and leaves the rest untouched, so
the KB stays in sync as the project evolves. Re-run it after notable changes, or
ask Claude Code to refresh the affected `kb/` file in the same session it edits
code.

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

[AGPL-3.0](LICENSE).
