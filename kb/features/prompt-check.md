# Feature — check prompt (`check.md`)

- **Purpose:** Install the drift checker in any repo — create `tools/kb-check.sh` + a sample `tools/hooks/pre-commit`, run it, and fix the pointers it flags. Focused, single-purpose.
- **When:** A repo whose KB predates the checker (older claude-kb setup), or any repo that just wants the drift gate without a full init/update. Solves agents SKIPPING the tool step inside the big prompts.
- **Also documented:** `README.md` "Drift-check prompt" section (embedded copy — keep byte-identical, see [[conventions]]).

## What it does

| Step | Source | Action |
|------|--------|--------|
| 1 | check.md "WHAT TO DO" step 1 | Create `tools/kb-check.sh` verbatim (the embedded script — symbol-aware, `--fix`) |
| 2 | check.md "WHAT TO DO" step 2 | Create the sample `tools/hooks/pre-commit` |
| 3 | check.md "WHAT TO DO" step 3 | RUN `--fix` (auto-repairs drifted lines), then a plain run; resolve leftover BROKEN/STALE by hand until `broken 0` |
| 4 | check.md "WHAT TO DO" step 4 | Tell the user how to install the opt-in hook |

## Rules & output

- Focused: only creates the two files + fixes flagged pointers; script written byte-for-byte; never installs the hook into `.git/` without asking (`check.md:77-82`).
- Output: whether kb-check ends OK + what was created/fixed (`check.md:83-85`).

## Notes

- The embedded `tools/kb-check.sh` is byte-identical to this repo's `tools/kb-check.sh` and the copies in [[prompt-init]] / [[prompt-update]] (gate: the bash block must equal the file).
- Same checker the [[prompt-verify]] audit runs first; this prompt only INSTALLS it. Contrast [[prompt-init]] / [[prompt-update]] (do much more, agents may skip the tool); this is the can't-skip path.
