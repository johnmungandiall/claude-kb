# ROLE
You are INSTALLING the claude-kb drift checker in THIS repo, so the KB's `path:line`
pointers are verified by a script instead of by memory. This is a FOCUSED job — do
NOT build or rebuild the KB and do NOT audit notes. Create the tool + a sample hook,
then prove it runs. Use this on a repo whose KB predates the checker, or any repo
that just wants the automation.

# WHAT TO DO
1. Create `tools/kb-check.sh` with EXACTLY this content (make the `tools/` dir if
   needed; overwrite an older copy). Write it verbatim — do not "improve" it:

```bash
#!/usr/bin/env bash
# kb-check.sh — verify KB code pointers RESOLVE and their line is in range, in
# WHATEVER form they are written: `path:line` (backtick), [text](path):line
# (markdown link), path):line (stray paren). The path may be root-relative OR
# relative to the note itself (e.g. ../../lib/...). A ref with no file path (e.g.
# start():226) is flagged as uncheckable. With --freshness, also flag notes older
# than the code they cite (git). Deps: git-bash builtins only. From the repo root:
#   bash tools/kb-check.sh [--freshness]
set -u
kb="kb"; [ -d "$kb" ] || { echo "run from the repo root (no kb/ here)"; exit 0; }
bad=0
resolve() {  # <note> <path> -> prints the existing file (root- or note-relative), else nothing
  [ -f "$2" ] && { printf '%s' "$2"; return; }
  [ -f "$(dirname "$1")/$2" ] && printf '%s' "$(dirname "$1")/$2"
}
# pointers that carry a file path:  <path>.<ext> [optional )] : <line>
while IFS= read -r hit; do
  note="${hit%%:*}"; r="${hit#*:}"; ptr="${r#*:}"
  ln="${ptr##*:}"; p="${ptr%:*}"; p="${p%\)}"
  f="$(resolve "$note" "$p")"
  if [ -z "$f" ]; then
    echo "  x $note -> $ptr  (file not found)"; bad=$((bad + 1))
  else
    t=$(wc -l < "$f" | tr -d ' '); [ "$ln" -le "$t" ] || { echo "  x $note -> $ptr  (file has $t lines)"; bad=$((bad + 1)); }
  fi
done < <(grep -rnoE '[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+\)?:[0-9]+' "$kb" 2>/dev/null)
# refs with NO file path (e.g. the function form start():226) — uncheckable, must be fixed
while IFS= read -r hit; do
  note="${hit%%:*}"; m="${hit#*:}"; m="${m#*:}"
  echo "  ? $note -> $m  (no file path — write it as a path:line)"; bad=$((bad + 1))
done < <(grep -rnoE '[A-Za-z_][A-Za-z0-9_]*\([^)]*\):[0-9]+' "$kb" 2>/dev/null)
if [ "${1:-}" = "--freshness" ]; then
  find "$kb" -name '*.md' | while IFS= read -r note; do
    nt=$(git log -1 --format=%ct -- "$note" 2>/dev/null) || continue; [ -n "$nt" ] || continue
    grep -oE '[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+\)?:[0-9]+' "$note" 2>/dev/null \
      | sed -e 's/):[0-9]*$//' -e 's/:[0-9]*$//' | sort -u | while IFS= read -r p; do
        f="$(resolve "$note" "$p")"; [ -n "$f" ] || continue
        ct=$(git log -1 --format=%ct -- "$f" 2>/dev/null); [ -n "$ct" ] || continue
        [ "$ct" -gt "$nt" ] && echo "  ~ $note  (points to newer $f — re-check)"
      done
  done
fi
[ "$bad" -eq 0 ] && { echo "kb-check: OK — all pointers resolve."; exit 0; }
echo "kb-check: $bad problem(s) above."; exit 1
```

2. Create a sample hook at `tools/hooks/pre-commit`, verbatim:

```bash
#!/usr/bin/env bash
# claude-kb sample pre-commit hook — block the commit if any KB pointer is broken.
# Install (pick one):
#   cp tools/hooks/pre-commit .git/hooks/pre-commit   # copy it in
#   git config core.hooksPath tools/hooks             # or point git at this dir
exec bash tools/kb-check.sh
```

3. RUN `bash tools/kb-check.sh` to confirm it works. Fix every problem it reports:
   make each pointer a full path from the repo root, drop stray punctuation, and
   convert `name():line` refs to `path:line`. Re-run until it prints OK. Do NOT
   report done until it runs clean.
4. Tell the user the hook is opt-in and how to install it (one of the two lines in
   the hook's header). Do NOT copy it into `.git/` for them without asking.

# RULES
- FOCUSED: the only edits you make are creating the two files and fixing the broken
  pointers the checker flags — no KB rebuild, no note rewrites, no new features.
- Write the script byte-for-byte as given above; don't change its behaviour.
- Never copy the hook into `.git/hooks/` without the user's say-so.

# OUTPUT
Say whether `tools/kb-check.sh` ends in OK, and list what you created plus any
broken pointers you fixed.
