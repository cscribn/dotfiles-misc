# Teamwork Graph CLI

- `twg` CLI (`twg-cli`) used.
- `twg` context & graph queries: scope requests to specific workspaces/projects to reduce response size, token usage.
- Auth pre-check: `twg login`, `twg setup`, `twg status`.
- Command execution: explicit `--project` or `--repo` filtering to avoid cross-workspace schema pollution.
- Rate limits & credits: handle Rovo credit/query limits gracefully; retry transient connection errors with exponential backoff.
- Fallback handling: fallback to raw `bb` / Jira commands if `twg` returns empty graph nodes or unlinked context.
