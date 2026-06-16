# claude-kb

**Cut Claude Code token usage by giving every session a compact map of your codebase.**

`claude-kb` ships two [Claude Code](https://claude.com/claude-code) slash commands that build and
maintain a tiny, token-efficient **knowledge base** (`kb/`) for any project — a tree of dense
Markdown notes that *summarize* your code and point to `path:line` instead of making Claude read
every file. Run it **once**; every future session then orients from `kb/` instead of re-scanning
the whole repo.

> **Why it saves tokens:** the KB never copies code — it references it. A 30-file feature collapses
> into a ~40-line note. Claude reads the map, not the territory, then opens only the exact files it
> needs.

---

## What you get

| Command | What it does |
|---|---|
| `/kb-index` | Scans the repo, writes the `kb/` tree, and wires your `CLAUDE.md` to read it first. Re-run anytime for an incremental refresh, or pass a feature/path to refresh just that note. |
| `/kb-remove` | Cleanly uninstalls: deletes `kb/` and removes **only** the `## Knowledge Base` section from `CLAUDE.md`. |

The generated KB (see [`examples/`](examples/)):

```
kb/
├── overview.md       # what it does, stack, entry point, how to run, last-indexed marker
├── architecture.md   # module map + data flow (how the pieces connect)
├── features/<x>.md   # one per feature: purpose, key files as path:line, key functions, gotchas
├── conventions.md    # naming, folder rules, recurring patterns
└── glossary.md       # domain / business terms
```

---

## Install

Pick a scope and copy the two command files into your `commands/` folder.

**Per-project** (commit it so your team gets the commands):
```bash
mkdir -p .claude/commands
cp /path/to/claude-kb/.claude/commands/kb-index.md  .claude/commands/
cp /path/to/claude-kb/.claude/commands/kb-remove.md .claude/commands/
```

**Global** (available in every project on your machine):
```bash
mkdir -p ~/.claude/commands
cp /path/to/claude-kb/.claude/commands/kb-index.md  ~/.claude/commands/
cp /path/to/claude-kb/.claude/commands/kb-remove.md ~/.claude/commands/
```

> On Windows PowerShell, use `Copy-Item` and `~\.claude\commands`.

---

## Usage

**Run once**, from inside the project you want indexed:

```
/kb-index
```

That's it. The command builds `kb/` and adds a `## Knowledge Base` pointer to your `CLAUDE.md`
(preserving everything already there). From then on it's **automatic** — Claude Code loads
`CLAUDE.md` at the start of every session, so each new session reads `kb/` first and keeps the
affected notes up to date as it changes code. No need to re-run anything.

Optional:
- `/kb-index payments` — refresh just the `payments` feature note after a focused change.
- `/kb-index` (no args) — full incremental refresh; only sections whose code changed are rewritten.

**Uninstall** when you no longer want it:
```
/kb-remove
```

See [`examples/CLAUDE.md`](examples/CLAUDE.md) for exactly what the wiring looks like, and
[`examples/kb/`](examples/kb/) for a realistic generated KB.

---

## How it works

1. `/kb-index` summarizes architecture, features, conventions, and gotchas into ≤50-line notes that
   reference code as `src/auth/login.ts:42` — never by pasting it.
2. It adds a short, link-only `## Knowledge Base` section to `CLAUDE.md` (a *pointer*, not a copy).
3. Because `CLAUDE.md` is auto-loaded every session, Claude reads the relevant `kb/` note before
   touching code, and refreshes that note in the same session after editing — keeping the map fresh
   without extra runs.

The structure is **stable** so re-runs are incremental: unchanged sections are left untouched.

---

## License

[AGPL-3.0-only](LICENSE). You may use, modify, and distribute this software under the terms of the
GNU Affero General Public License v3.0 — including the requirement to offer source for network/SaaS
use. See [`LICENSE`](LICENSE) for the full text.

## Contributing

Issues and PRs welcome. Keep the commands provider-agnostic about your codebase and faithful to the
core rule: **the KB summarizes and links to code; it never copies it.**
