<!-- EXAMPLE — sample feature note. -->
> One-line: Offline-first sync engine reconciling IndexedDB with Supabase.

# Feature: Sync
- **Purpose**: Keep local notes and cloud in sync; work fully offline.
- **Strategy**: offline-first writes; background queue flush; last-write-wins.

## Key files
| Path:line | Role |
|---|---|
| `src/sync/engine.ts:58` | Queue flush loop + retry/backoff |
| `src/sync/queue.ts:12` | Persistent op queue in Dexie table `_outbox` |
| `src/api/supabase.ts:91` | Realtime subscription → inbound merge |
| `src/db/dexie.ts:24` | `notes` + `_outbox` schema/versions |

## Key functions
- `engine.ts:58 flush()` — drains `_outbox`, marks ops sent, handles 409 conflicts.
- `supabase.ts:91 subscribe()` — applies remote deltas via `mergeRemote()` (`engine.ts:120`).

## Gotchas
- Clock skew breaks last-write-wins → server `updated_at` is authoritative, not client.
- Bump Dexie `version()` on schema change or migrations silently fail (`dexie.ts:24`).
- Queue must be idempotent; ops carry a client-generated `opId`.

Related: [[architecture]], [[features/auth]], [[glossary]].
