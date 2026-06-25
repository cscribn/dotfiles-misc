# GitHub CLI

- `gh` CLI used (not Octokit/direct HTTP clients).
- REST listing/commits: `gh api --paginate` (not `--jq`).
- GraphQL used for PRs/reviews.
- Rate limits respected with wait-until-reset retry.
