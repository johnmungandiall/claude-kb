# Cheatsheet — how to use this repo (Markdown-only; no build/test/lint).

## The five prompts (paste into Claude Code on a target repo)
- `prompt.md` — first-time KB bootstrap (no `kb/` yet).
- `update.md` — upgrade an existing KB to the latest spec.
- `verify.md` — audit an existing KB for drift vs the code.
- `slim.md` — shrink a bloated `CLAUDE.md` (migrate reference content into `kb/`).
- `check.md` — install `tools/kb-check.sh` + sample hook (focused, can't-skip).

## Entry points
- `prompt.md`, `update.md`, `verify.md`, `slim.md`, `check.md` — the prompts.
- `.claude/agents/` — KB subagents (kb-maintainer/verify/slim), auto-created by the prompts.
- `tools/kb-check.sh` — pointer/freshness drift checker.
- `README.md` — human docs; links to the prompt files (does NOT embed them).
- `kb/` — this repo's own dogfooded KB.

## KB drift check (run before release / on a pre-commit hook)
```bash
bash tools/kb-check.sh              # every path:line pointer resolves? (exit 1 if not)
bash tools/kb-check.sh --freshness  # also flag notes older than the code they cite
cp tools/hooks/pre-commit .git/hooks/pre-commit   # install the opt-in commit gate
```

See [[gotchas]] for traps, [[edit-a-prompt]] for the full edit runbook, [[overview]] for what this repo is.
