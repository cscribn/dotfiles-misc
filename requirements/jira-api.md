# Jira API

- `/rest/api/3/search/jql` used for JQL.
- Pagination (`nextPageToken`, `isLast`, `maxResults`) used.
- 401/403/rate-limit handled explicitly.
- Bulk endpoints used.
- Auth via `JIRA_EMAIL` + `JIRA_API_TOKEN` env vars; `JIRA_BASE_URL` for site root and browse-link construction.
