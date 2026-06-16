<!-- EXAMPLE — sample output of /kb-index for a fictional "Acme Notes" app. -->
> One-line: Module map and data flow — how UI, state, local storage, and cloud sync connect.

# Architecture
## Module map
| Layer | Path | Responsibility |
|---|---|---|
| UI | `src/components/` | Presentational + container components |
| Routing | `src/routes/` | Route table, lazy-loaded pages |
| State | `src/store/` | Zustand stores (notes, auth, ui) |
| Local data | `src/db/dexie.ts` | IndexedDB schema + queries |
| Cloud | `src/api/supabase.ts` | Auth + remote CRUD |
| Sync | `src/sync/engine.ts` | Reconciles local ⇄ cloud |

## Data flow
1. Component reads/writes via a Zustand store action (`src/store/notes.ts:34`).
2. Store action writes to Dexie first (offline-first), then enqueues a sync job.
3. `sync/engine.ts:58` flushes the queue to Supabase; conflicts resolved last-write-wins.
4. Realtime Supabase subscription (`src/api/supabase.ts:91`) pushes remote changes back into Dexie → store → UI.

## Cross-cutting
- Auth gate: `src/routes/Guard.tsx:18` redirects unauthenticated users.
- Errors bubble to `src/components/ErrorBoundary.tsx:9`.

Related: [[features/sync]], [[features/auth]], [[conventions]].
