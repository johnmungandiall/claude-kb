# Acme Notes

<!--
EXAMPLE CLAUDE.md — shows what /kb-index adds to YOUR project's CLAUDE.md.
Everything above and below the "## Knowledge Base" section is YOUR existing
content; /kb-index preserves it and only adds/refreshes that one section.
/kb-remove deletes only that section.
-->

Project-specific notes you already had live here (build steps, house rules, etc.).
`/kb-index` never touches them.

## Knowledge Base (read FIRST — saves tokens)
This repo has a compact KB in `kb/`. Before any task, read the relevant `kb/`
files to orient instead of scanning the whole codebase. After changing code,
update the affected `kb/` file(s) in the SAME session. Map of the KB:
- kb/overview.md — what Acme Notes is, stack, entry point, how to run
- kb/architecture.md — module map + local⇄cloud data flow
- kb/features/ — auth (Supabase sign-in), sync (offline-first engine)
- kb/conventions.md, kb/glossary.md

## Other sections
Any further sections of your own keep working exactly as before.
