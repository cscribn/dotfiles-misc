# Bitbucket CLI

- `bb` CLI (`@pilatos/bitbucket-cli`) used.
- `bb api` pagination via `next`
- Rate limits/transient gateway errors: exponential backoff; parse `Retry-After` from `bb` output when present; minimum 30s on first 429 without `Retry-After`.
- Auth pre-check: `bb --version`, `bb auth status`.
