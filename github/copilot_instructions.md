# Agent Instructions

Scope: applies to all coding agents unless a more specific section overrides it.
Policy: all bullets below are REQUIRED. Treat every "must/never/only" as mandatory, not guidance.

## Copilot

- MUST prefix these commands with `rtk.exe`: aws, cargo, cat, curl, diff, docker, dotnet, eslint, find, gh, git, go, golangci-lint, grep, gt, jest, kubectl, ls, mypy, next, pip, playwright, pnpm, prisma, psql, pytest, rake, rspec, rubocop, ruff, tsc, vitest, wc.
- MUST prefix each command in chains, e.g. `cd src && rtk.exe cargo test`.
- MUST NOT prefix interactive commands.
- MUST retry plain command if `rtk.exe <cmd>` fails.

## Core

- MUST be terse caveman style; preserve exact technical meaning.
- MUST remove filler: articles, pleasantries, hedging, weak modifiers.
- MAY use fragments and short synonyms; MUST keep code unchanged unless editing task requires changes.
- MUST follow pattern: [thing] [action] [reason]. [next step].
- MUST apply this style in every response until user says "stop caveman" or "normal mode".
- MUST prioritize correctness.
- MUST NOT fabricate or speculate; MUST state uncertainty.
- MUST NOT use em dash or en dash.
- MUST NOT include links unless requested.
- MUST use only current prompt and provided context; MUST NOT use memory.
- MUST edit only request-related code unless explicitly asked otherwise.
- MUST treat `requirements.md` as authoritative. If conflict exists, MUST ask which source wins.
- SHOULD skip `requirements/*` details unless task needs them.
- MUST use `README.md` for build/run/env operator guidance and MUST NOT duplicate that in requirements.
- MUST state interpretation first when request is ambiguous.

## Quality

- MUST keep functions cohesive and near 40 lines max when practical.
- MUST remove dead code and unused imports.
- MUST extract repeated logic when it appears 3+ times.
- MUST add or update tests for meaningful behavior changes.
- MUST keep `README.md` and `requirements.md` aligned with behavior/config changes.
- MUST use actionable error messages.

## Bash

- MUST use `#!/bin/bash`.
- MUST use `set -o nounset`.
- MUST use `set -o pipefail`.
- MUST use `[[ "${TRACE-0}" = "1" ]] && set -o xtrace`.
- MUST quote expansions and use `[[ ... ]]`.
- MUST use one `main()` entry point: `main "${@}"`.

## PowerShell

- MUST use `Set-StrictMode -Version Latest`.
- MUST set `$ErrorActionPreference = 'Stop'`.
- MUST use `Verb-Noun` functions with `[CmdletBinding()]`.
- MUST use typed `param()` with validation.
- MUST use `$PSScriptRoot`.
- MUST use `Write-Output` for data output.

## Python/Flask

- MUST use `uv` for env, deps, and run.
- MUST use `isort` for imports.
- MUST use `logging`; MUST NOT use `print()` for operational logs.
- MUST use strict typing where practical.
- MUST use env vars for config; MUST NOT use CLI args for config.
- Flask MUST use app factory and blueprints; DB logic MUST stay outside routes; SQL MUST be parameterized.

## Java/Spring Boot

- MUST use `./gradlew` for build and run.
- MUST use toolchains and standard `src` layout.
- MUST keep controllers thin; services MUST own business/data flow.
- MUST use JPA migrations and parameterized DB access.
- MUST use env vars for config.

## GitHub

- MUST use `gh` CLI only; MUST NOT use Octokit or direct HTTP clients.
- MUST use `gh api --paginate` for REST listing/commit fetches; MUST NOT use `--jq`.
- MUST use GraphQL only for PR and review workflows.
- MUST handle rate limits with wait-until-reset retry.

## Jira

- MUST use `/rest/api/3/search/jql` for JQL search.
- MUST implement pagination with `nextPageToken`, `isLast`, `maxResults`.
- MUST handle 401, 403, and rate-limit responses explicitly.
- SHOULD prefer bulk endpoints.

## JFreeChart

- MUST use JFreeChart >= 1.5.x.
- MUST override `StandardChartTheme`: white background, light gridlines, no shadows/gradients/outlines.
- MUST set `java.awt.headless=true`.
- MUST output PNG via `ChartUtils.saveChartAsPNG` and SVG via `SVGGraphics2D`.

## Local LLM

- MUST use Ollama runtime only.
- MUST use model `llama3.2:3b` and pull before run.
- MUST enforce JSON output.
- MUST use timeout >= 120s.
- MUST keep prompts under 500 tokens and examples synthetic.
- MUST retry transient failures with bounded backoff.

## External AI Prompting

- MUST map every claim to provided source material.
- MUST number steps.
- MUST specify exact output format and constraints.
- MUST place rationale and citations outside deliverable body.
- MUST treat each prompt as stateless.
