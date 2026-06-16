<!-- EXAMPLE — sample output of /kb-index for a fictional "Acme Notes" app. -->
> One-line: What Acme Notes is, its stack, entry point, and how to run it.

# Overview
- **What**: Acme Notes — a markdown note-taking web app with offline sync.
- **Stack**: TypeScript, React 18, Vite, Zustand (state), Dexie/IndexedDB (local), Supabase (cloud).
- **Entry point**: `src/main.tsx:1` → mounts `<App>` from `src/App.tsx:12`.
- **Run**:
  - dev — `npm run dev` (Vite on :5173)
  - build — `npm run build` → `dist/`
  - test — `npm test` (Vitest)
- **Env**: copy `.env.example` → `.env`; needs `VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`.
- **Deploy**: static `dist/` to Netlify; Supabase project hosts auth + Postgres.

See [[architecture]] for how the pieces connect.

**last indexed**: 2026-06-16 (commit a1b2c3d)
