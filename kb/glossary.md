# Glossary — terms used in claude-kb.

| Term | Meaning |
|------|---------|
| **KB** | Knowledge base — `kb/` tree of compact Markdown maps |
| **AUTO-MAINTAIN** | Rule: any code/config change in same session must update affected `kb/` notes |
| **Map** | Short orientation notes; not a code copy |
| **Init prompt** | `prompt.md` — first-time KB bootstrap |
| **Update prompt** | `update.md` — spec upgrade without rebuild |
| **Pointer** | `CLAUDE.md` links to `kb/`; does not embed KB text |
| **last indexed** | Date/commit marker in `kb/overview.md` after (re)indexing |
| **Sub-project** | Monorepo package (`apps/`, `packages/`, etc.) gets `kb/subprojects/<name>.md` |
| **about-you** | `kb/about-you.md` — durable user prefs (style, tech, goals, rules); the USER half of the KB, tagged [confirmed]/[inferred] |
| **Verify prompt** | `verify.md` — audits the KB for DRIFT vs code; fixes cheap mismatches, reports the rest |
| **Drift** | KB notes no longer matching the code (stale `path:line`, wrong claim, orphan, broken `[[link]]`) |
| **gotchas / changelog / cheatsheet** | Optional notes: repo traps, dated KB history, one-page command reference |
| **(checked &lt;date&gt;)** | Freshness marker on a volatile `path:line` so staleness is visible |
