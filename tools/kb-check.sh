#!/usr/bin/env bash
# kb-check.sh — fail if any kb/ `path:line` pointer no longer resolves (file
# exists + line in range). With --freshness, also flag notes older than the code
# they cite (git). Deps: git-bash builtins only. Run from the repo root:
#   bash tools/kb-check.sh [--freshness]
set -u
kb="kb"; [ -d "$kb" ] || { echo "run from the repo root (no kb/ here)"; exit 0; }
re='`[A-Za-z0-9_./-]+\.[A-Za-z0-9_]+:[0-9]+'   # `full/path.ext:line` (range :a-b matches a)
bad=0
while IFS= read -r h; do
  note="${h%%:*}"; m="${h#*:}"; m="${m#*:}"; p="${m#\`}"
  f="${p%:*}"; n="${p##*:}"
  if [ ! -f "$f" ]; then
    echo "  x $note -> \`$p\`  (no such file — use a full path from the repo root)"; bad=$((bad + 1))
  else
    t=$(wc -l < "$f" | tr -d ' '); [ "$n" -le "$t" ] || { echo "  x $note -> \`$p\`  (file has $t lines)"; bad=$((bad + 1)); }
  fi
done < <(grep -rnoE "$re" "$kb" 2>/dev/null)
if [ "${1:-}" = "--freshness" ]; then
  find "$kb" -name '*.md' | while IFS= read -r note; do
    nt=$(git log -1 --format=%ct -- "$note" 2>/dev/null) || continue; [ -n "$nt" ] || continue
    grep -oE "$re" "$note" 2>/dev/null | sed -e 's/^`//' -e 's/:[0-9]*$//' | sort -u | while IFS= read -r f; do
      [ -f "$f" ] || continue; ct=$(git log -1 --format=%ct -- "$f" 2>/dev/null); [ -n "$ct" ] || continue
      [ "$ct" -gt "$nt" ] && echo "  ~ $note  (points to newer $f — re-check)"
    done
  done
fi
[ "$bad" -eq 0 ] && { echo "kb-check: OK — all pointers resolve."; exit 0; }
echo "kb-check: $bad broken pointer(s)."; exit 1
