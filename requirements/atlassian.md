# Atlassian

## Bitbucket CLI (`@pilatos/bitbucket-cli`)

- **Use for**: Repos, PR workflows, pipelines, and fallback reads when `twg` is insufficient.
- **Pre-check**: `bb --version`, `bb auth status`.
- **Pagination**: Use `bb api` with `next`.
- **Rate Limits**: Use exponential backoff. Parse `Retry-After`; default to 30s minimum on first 429 without it.

## Confluence API

- **Use for**: Direct writes and fallback reads when `twg` returns incomplete page metadata.
- **Auth**: `JIRA_EMAIL`, `JIRA_API_TOKEN`, `JIRA_BASE_URL`.
- **Errors**: Explicitly handle 401, 403, and rate limits.

## Jira API

- **Use for**: Direct writes, precise JQL filtering, custom pagination, or raw issue schemas.
- **Endpoints**: `/rest/api/3/search/jql` for JQL; use bulk endpoints where applicable.
- **Auth**: `JIRA_EMAIL`, `JIRA_API_TOKEN`, `JIRA_BASE_URL`.
- **Optimization**: Use `nextPageToken`, `isLast`, `maxResults`. Limit `fields` parameter to minimize payload size.
- **Errors**: Explicitly handle 401, 403, and rate limits.

## Teamwork Graph CLI (`twg-cli`)

- **Use for**: Primary read layer for multi-product context, cross-entity graph queries, and AI agent retrieval.
- **Pre-check**: `twg env auth --no-snapshot` (use `twg login`/`setup` only for interactive setup).
- **Execution**: Scope queries with explicit `--project` or `--repo` flags to minimize payload, token usage, and schema pollution.
- **Rate Limits**: Handle Rovo credit limits; retry transient errors with exponential backoff.
- **Fallback to APIs/CLI when**: `twg` node is empty/unlinked, raw JSON/diffs are required, or running high-frequency bulk extractions.
