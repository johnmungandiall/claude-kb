# Cheatsheet — how to use this repo (Markdown-only; no build/test/lint).

## The three prompts (paste into Claude Code on a target repo)
- `prompt.md` — first-time KB bootstrap (no `kb/` yet).
- `update.md` — upgrade an existing KB to the latest spec.
- `verify.md` — audit an existing KB for drift vs the code.

## Entry points
- `prompt.md`, `update.md`, `verify.md` — the prompts.
- `README.md` — human docs + verbatim copies of all three prompts.
- `kb/` — this repo's own dogfooded KB.

## README ↔ prompt sync check (run after editing any prompt)
```bash
for n in 1:prompt.md 3:update.md 5:verify.md; do
  i=${n%%:*}; f=${n##*:}
  diff <(awk -v b=$i '/^````/{c++; next} c==b' README.md | sed 's/\r$//') \
       <(sed 's/\r$//' "$f") && echo "$f IN SYNC"
done
```

See [[gotchas]] for traps, [[overview]] for what this repo is.
