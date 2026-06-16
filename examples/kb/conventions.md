<!-- EXAMPLE — sample conventions note. -->
> One-line: Naming, folder rules, and recurring patterns in this codebase.

# Conventions
## Naming
- Components: `PascalCase.tsx`; hooks: `useCamelCase.ts`; stores: `camelCase.ts`.
- Files export ONE primary symbol matching the filename.
- Async actions return `{ data, error }`, never throw across layers.

## Folders
- `components/` = presentational; containers live next to their route in `routes/`.
- No cross-imports between feature folders — share via `store/` or `lib/`.
- Test files co-located as `*.test.ts(x)` beside source.

## Patterns
- State only via Zustand actions; components never write Dexie/Supabase directly.
- All side effects funnel through `store/` → keeps components pure + testable.
- Env access only in `src/config.ts:1`; never read `import.meta.env` elsewhere.

## Tooling
- Lint/format: ESLint + Prettier (`npm run lint`); CI blocks on errors.
- Commits: Conventional Commits (`feat:`, `fix:`, …).

Related: [[architecture]], [[glossary]].
