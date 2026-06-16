<!-- EXAMPLE — sample glossary note. -->
> One-line: Domain and business terms used across Acme Notes.

# Glossary
| Term | Meaning |
|---|---|
| Note | A markdown document; the core entity (`db/dexie.ts:24`). |
| Outbox | Local queue of unsynced write ops (`sync/queue.ts:12`). |
| Op / opId | A single sync operation + its client-generated idempotency key. |
| Workspace | A user's collection of notes; 1:1 with a Supabase account today. |
| Magic link | Passwordless email sign-in token from Supabase Auth. |
| LWW | Last-write-wins — conflict rule keyed on server `updated_at`. |
| Splash | Loading screen shown until `auth.ready` resolves (`store/auth.ts:55`). |

Related: [[features/sync]], [[features/auth]], [[conventions]].
