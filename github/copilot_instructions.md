# Agent Instructions

Scope: applies to all coding agents unless overridden by a more specific section.

## Copilot

- OS: Windows
- Terminal: Git Bash (POSIX/Bash syntax only)
- Constraint: Never use PowerShell, pwsh, or cmd. Always use Bash.

## Core

- Be concise. No filler.
- Prioritize correctness.
- No fabrication or speculation; state uncertainty.
- Do not use em/en dashes.
- No links unless requested.
- Use only current prompt/context, not memory.
- Edit only code related to the request unless explicitly asked.
- If request conflicts with `requirements.md`, stop and ask which wins.
- If ambiguous, state your interpretation first.

## Quality

- Keep functions small and cohesive (about 40 lines max, low complexity).
- Remove dead code and unused imports.
- Extract repeated logic when it appears 3+ times.
- Add/update tests for meaningful behavior changes.
- Keep README and `requirements.md` in sync with behavior/config changes.
- Use actionable error messages.

## Bash

- `#!/bin/bash`
- `set -o nounset`
- `set -o pipefail`
- `[[ "${TRACE-0}" = "1" ]] && set -o xtrace`
- Use quoted expansions and `[[ ... ]]`.
- Use one `main()` entry point: `main "${@}"`.

## PowerShell

- `Set-StrictMode -Version Latest`
- `$ErrorActionPreference = 'Stop'`
- Use `Verb-Noun` functions with `[CmdletBinding()]`.
- Use typed `param()` with validation.
- Use `$PSScriptRoot`.
- Prefer `Write-Output` for data.

## Python/Flask

- Use `uv` for env/deps/run.
- Use `isort` for imports.
- Use `logging`, not `print()`.
- Prefer strict typing.
- Use env vars for config (no CLI args).
- Flask: app factory + blueprints; DB logic outside routes; SQL parameterization only.

## Java/Spring Boot

- Use `./gradlew` for build/run.
- Use toolchains and standard src layout.
- Keep controllers thin; services handle business/data flow.
- Use JPA migrations and parameterized DB access.
- Env vars for config.

## GitHub

- Use `gh` CLI only (no Octokit/direct HTTP clients).
- REST listing/commits: `gh api --paginate` (no `--jq`).
- Use GraphQL only for PRs/reviews.
- Respect rate limits with wait-until-reset retry.

## Jira

- Use `/rest/api/3/search/jql` for JQL.
- Use pagination (`startAt`, `maxResults`, `total`).
- Handle 401/403/rate-limit explicitly.
- Prefer bulk endpoints.

## JFreeChart

- Use >= 1.5.x.
- Override `StandardChartTheme`; white backgrounds, light gridlines, no shadows/gradients/outlines.
- Set `java.awt.headless=true`.
- PNG via `ChartUtils.saveChartAsPNG`; SVG via `SVGGraphics2D`.

## Local LLM

- Runtime: Ollama only.
- Model: `llama3.2:3b` (pull before run).
- Enforce JSON output.
- Timeout >= 120s.
- Keep prompts < 500 tokens, synthetic examples only.
- Retry transient failures with bounded backoff.

## External AI Prompting

- Every claim must map to provided source material.
- Number steps.
- Specify exact output format and constraints.
- Put rationale/citations outside deliverable body.
- Treat each prompt as stateless.
