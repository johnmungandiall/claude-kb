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
