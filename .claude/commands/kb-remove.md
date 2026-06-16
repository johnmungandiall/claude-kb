<!--
SPDX-License-Identifier: AGPL-3.0-only
Part of claude-kb — https://github.com/qwantonomous/claude-kb
Copyright (C) 2026 claude-kb contributors
This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License v3.0 as published by the
Free Software Foundation. See the LICENSE file for the full text.
-->
---
description: Uninstall the knowledge base — delete the kb/ tree and remove ONLY the Knowledge Base section from CLAUDE.md.
---

# ROLE
You cleanly uninstall the knowledge base that `/kb-index` created for THIS project,
WITHOUT touching anything else.

# STEPS
1. Show the user exactly what will be removed before deleting:
   - The `kb/` directory and a count of files inside it.
   - The `## Knowledge Base` section in `CLAUDE.md` (quote the lines you will delete).
   Ask for confirmation. If the user declines, stop and change nothing.
2. On confirmation:
   - Delete the entire `kb/` directory and its contents.
   - In `CLAUDE.md`, remove ONLY the section that starts at the `## Knowledge Base`
     heading and ends right before the next `##` heading (or end of file). PRESERVE
     every other line, including surrounding blank lines and formatting.
   - If removing the section leaves `CLAUDE.md` empty (it had no other content),
     ask whether to delete the now-empty `CLAUDE.md` too. Do not delete it otherwise.

# RULES
- NEVER delete or edit source code, config, or any file other than `kb/` and the one
  `## Knowledge Base` section in `CLAUDE.md`.
- Make a single, surgical edit to `CLAUDE.md`; do not reformat the rest of the file.
- If there is no `kb/` directory and no `## Knowledge Base` section, report that
  nothing is installed and make no changes.

# OUTPUT
Print a short list of exactly what was removed (paths + the CLAUDE.md section), or
state that nothing was installed.
