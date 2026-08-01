# Atlassian

## Bitbucket CLI

- Use for Git repos, PR workflows, pipeline execution, fallback reads for repos when `twg` is insufficient.
- `bb` CLI (`@pilatos/bitbucket-cli`) used.
- `bb api` pagination via `next`
- Rate limits/transient gateway errors: exponential backoff; parse `Retry-After` from `bb` output when present; minimum 30s on first 429 without `Retry-After`.
- Auth pre-check: `bb --version`, `bb auth status`.

## Jira API

- Use for direct write operations; as a fallback read layer when precise JQL filtering, pagination control, or raw issue schemas are required.
- `/rest/api/3/search/jql` used for JQL.
- Pagination (`nextPageToken`, `isLast`, `maxResults`) used; limit `fields` param on reads to avoid payload bloat.
- 401/403/rate-limit handled explicitly.
- Bulk endpoints used.
- Auth via `JIRA_EMAIL` + `JIRA_API_TOKEN` env vars; `JIRA_BASE_URL` for site root and browse-link construction.

## Teamwork Graph CLI

- Use as primary read layer for multi-product context, cross-entity relationships, AI-agent context retrieval.
- `twg` CLI (`twg-cli`) used.
- `twg` context & graph queries: scope requests to specific workspaces/projects to reduce response size, token usage.
- Auth pre-check: `twg status` for headless/automated runs (`twg login` / `twg setup` for interactive setup only).
- Command execution: explicit `--project` or `--repo` filtering to avoid cross-workspace schema pollution.
- Rate limits & credits: handle Rovo credit/query limits gracefully; retry transient connection errors with exponential backoff.
- Fall back to Jira API or `bb` CLI when: `twg` returns empty nodes, unlinked relationships, incomplete context; raw/uncompressed JSON OR Git diffs/files required; running high-frequency bulk extraction jobs.
