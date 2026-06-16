<!-- EXAMPLE — sample feature note. -->
> One-line: Email/OAuth auth via Supabase, route guarding, and session persistence.

# Feature: Auth
- **Purpose**: Sign in/out, persist session, gate private routes.
- **Provider**: Supabase Auth (email magic-link + Google OAuth).

## Key files
| Path:line | Role |
|---|---|
| `src/store/auth.ts:20` | `signIn`, `signOut`, `session` state |
| `src/api/supabase.ts:40` | `getSession`, `onAuthStateChange` wiring |
| `src/routes/Guard.tsx:18` | Redirect unauthenticated → `/login` |
| `src/components/LoginForm.tsx:31` | Email + OAuth UI |

## Key functions
- `auth.ts:20 signIn(email)` — sends magic link; sets `pending` flag.
- `supabase.ts:40 onAuthStateChange` — syncs Supabase session → store on refresh.

## Gotchas
- Session restores async on load → render a splash until `auth.ready` (`auth.ts:55`),
  or Guard flashes the login page.
- Magic-link redirect URL must be whitelisted in Supabase dashboard.

Related: [[architecture]], [[features/sync]].
