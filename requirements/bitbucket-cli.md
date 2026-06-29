# Bitbucket CLI

- `bb` CLI (`@pilatos/bitbucket-cli`) used.
- `bb api` pagination via `next`
- Rate limits/transient gateway errors: exponential backoff; parse `Retry-After` from `bb` output when present; minimum 30s on first 429 without `Retry-After`.
- 429 → coordinated shared pause across workers; concurrency permit not held during backoff sleep.
- `X-RateLimit-NearLimit: true` in response output (access-token auth) temporarily lowers concurrent `bb api` cap from 8 to 4.
- Auth pre-check: `bb --version`, `bb auth status`.
