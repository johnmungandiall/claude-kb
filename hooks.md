# ROLE
You are INSTALLING the claude-kb workflow hooks in THIS repo — Claude Code lifecycle
hooks that make the KB-maintenance rules fire AUTOMATICALLY instead of relying on the
model to remember them. This is a FOCUSED job: create two hook scripts, wire them into
`.claude/settings.json`, and tell the user. Do NOT build or rebuild the KB, do NOT audit
notes, do NOT touch source code. Framework-agnostic — these hooks hardcode NO language.

Two hooks get installed:
- **PostToolUse** (after Edit/Write) → once per session, reminds you to update the
  affected `kb/` note when you change code/config (the "auto-maintain" rule).
- **Stop** (before the turn ends) → runs `tools/kb-check.sh` and, if any `kb/` pointer
  is broken, blocks the stop ONCE and feeds the drift back so you fix it before finishing.

Prereqs: Python 3 on PATH (`python` on Windows, `python3` on macOS/Linux) and `bash`
(the Stop hook calls `tools/kb-check.sh`). The Stop hook is a no-op until that script
exists — pair this with `check.md` (or `prompt.md`) if the repo has no checker yet.

# WHAT TO DO
1. Create `.claude/hooks/kb_update_reminder.py` with EXACTLY this content (make the
   dirs if needed; overwrite an older copy). Write it verbatim — do not "improve" it:

```python
#!/usr/bin/env python3
"""PostToolUse hook (Write|Edit|MultiEdit): once per session, after Claude edits a
source/config file the kb/ notes map, remind it to update the matching kb/ note in the
SAME session (the CLAUDE.md / kb/about-kb.md auto-maintain rule). Non-blocking — only
injects context. Framework-agnostic: it hardcodes NO language's extensions; it reminds
for any edit OUTSIDE kb/, .claude/, .git/ and the top-level docs.

Stdlib only (no jq / no third-party deps); works on Windows + Unix.
"""
import json
import os
import sys
import tempfile

# Editing these never triggers a reminder (they are not "source the KB maps").
SKIP_DIRS = ("/kb/", "/.claude/", "/.git/", "/node_modules/")
SKIP_NAMES = ("claude.md", "memory.md", "readme.md")


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        return

    tool_input = data.get("tool_input") or {}
    tool_resp = data.get("tool_response") or {}
    fp = tool_input.get("file_path")
    if not fp and isinstance(tool_resp, dict):
        fp = tool_resp.get("filePath")
    if not fp:
        return

    norm = fp.replace("\\", "/").lower()
    base = os.path.basename(norm)
    if any(d in norm for d in SKIP_DIRS) or base in SKIP_NAMES:
        return

    # Remind at most once per session to avoid noise on multi-edit sessions.
    sid = str(data.get("session_id") or "nosid")
    safe_sid = "".join(c for c in sid if c.isalnum() or c in "-_") or "nosid"
    marker = os.path.join(tempfile.gettempdir(), "claude-kb-reminder-%s.flag" % safe_sid)
    if os.path.exists(marker):
        return
    try:
        open(marker, "w").close()
    except Exception:
        pass

    msg = (
        "KB upkeep (CLAUDE.md rule): you changed `%s` this session. Before ending "
        "your turn, update the affected kb/ note(s) in the SAME session — refresh any "
        "path:line pointers and changed behavior — then run `bash tools/kb-check.sh` "
        "and confirm it reports 0 broken. For a non-trivial change, dispatch the "
        "kb-maintainer subagent." % os.path.basename(fp)
    )
    print(json.dumps({
        "hookSpecificOutput": {
            "hookEventName": "PostToolUse",
            "additionalContext": msg,
        }
    }))


if __name__ == "__main__":
    main()
```

2. Create `.claude/hooks/kb_drift_check.py` with EXACTLY this content, verbatim:

```python
#!/usr/bin/env python3
"""Stop hook: before the session ends, run tools/kb-check.sh. If any kb/ note has a
BROKEN explicit-file pointer (kb-check exits non-zero), block the stop ONCE and feed the
drift back so Claude fixes it before finishing.

Safety: guarded by `stop_hook_active` so it nudges at most once and never loops; any
tooling error just allows the stop (never traps the user). kb-check only exits non-zero
on genuinely broken full-path pointers, so this is low-false-positive. No-op when the
checker is absent.

Stdlib only (no jq / no third-party deps); works on Windows + Unix.
"""
import json
import os
import subprocess
import sys


def main():
    try:
        data = json.load(sys.stdin)
    except Exception:
        data = {}

    # If we are here because THIS hook already blocked once, let the stop proceed.
    if data.get("stop_hook_active"):
        return

    root = os.environ.get("CLAUDE_PROJECT_DIR") or os.getcwd()
    checker = os.path.join(root, "tools", "kb-check.sh")
    if not os.path.isfile(checker):
        return

    try:
        result = subprocess.run(
            ["bash", "tools/kb-check.sh"],
            cwd=root,
            capture_output=True,
            text=True,
            timeout=60,
        )
    except Exception:
        return  # never block on a tooling hiccup

    if result.returncode == 0:
        return  # all kb/ pointers resolve -> allow stop

    drift = ((result.stdout or "") + (result.stderr or "")).strip()
    reason = (
        "KB drift detected before stop: kb/ notes have broken pointers. Fix them, "
        "update the affected note(s), then re-run `bash tools/kb-check.sh` until it "
        "reports 0 broken:\n\n" + drift
    )
    print(json.dumps({"decision": "block", "reason": reason}))


if __name__ == "__main__":
    main()
```

3. Wire both hooks into `.claude/settings.json`. If the file exists, MERGE this `hooks`
   block into it — preserve every existing key (`permissions`, other hooks, etc.) and
   APPEND to any matcher array already there; do NOT overwrite the file. If it does not
   exist, create it with exactly this:

```json
{
  "hooks": {
    "PostToolUse": [
      {
        "matcher": "Edit|Write|MultiEdit",
        "hooks": [
          {
            "type": "command",
            "command": "python \"${CLAUDE_PROJECT_DIR}/.claude/hooks/kb_update_reminder.py\""
          }
        ]
      }
    ],
    "Stop": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python \"${CLAUDE_PROJECT_DIR}/.claude/hooks/kb_drift_check.py\"",
            "timeout": 60
          }
        ]
      }
    ]
  }
}
```

   On macOS/Linux, if `python` is not on PATH, change `python` to `python3` in BOTH
   commands.

4. Tell the user what landed and how to control it:
   - The PostToolUse reminder is non-blocking (injects a note at most once per session).
   - The Stop hook can block the END of a turn ONCE when `tools/kb-check.sh` exits
     non-zero; it never loops (guarded by `stop_hook_active`) and is a no-op if the
     checker is missing.
   - To disable either, remove its entry from `.claude/settings.json`.
   Do NOT enable anything outside these two hooks without asking.

# RULES
- FOCUSED: the only changes are the two hook files + the `.claude/settings.json` hooks
  wiring. No KB rebuild, no note edits, no source changes.
- Write both scripts byte-for-byte as given; don't "improve" them. They are stdlib-only
  (no `jq`, no third-party deps) and run on Windows + Unix.
- MERGE settings.json, never clobber it — a target repo likely already has `permissions`
  and maybe other hooks; keep them.
- Keep it framework-agnostic: do NOT add language-specific extension filters. The
  reminder fires for any edit outside `kb/`, `.claude/`, `.git/`, `node_modules/`, and
  the top-level docs.

# OUTPUT
List the two files you created, confirm the `.claude/settings.json` hooks were MERGED
(not overwritten), and note the Python command form used (`python` vs `python3`).
