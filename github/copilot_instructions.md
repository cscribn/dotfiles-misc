# Agent Instructions/Rules

## Bash

- **Scope:** Apply this style to new scripts and when refactoring existing scripts.
- **Shebang:** Start scripts with `#!/bin/bash`.
- **Strict Mode:** Use `set -o nounset` and `set -o pipefail`.
- **Tracing:** Support optional tracing with `[[ "${TRACE-0}" = "1" ]] && set -o xtrace`.
- **Metadata:** Define script metadata early and mark immutable values as `readonly`.
- **Script Name:** Set `SCRIPT_NAME` via `basename`.
- **Script Directory:** Set `SCRIPT_DIR` via `BASH_SOURCE[0]`.
- **Functions:** Keep logic in small functions and use `local` variables inside functions.
- **Entry Point:** Keep a single `main()` function at the bottom and invoke it with `main "${@}"`.
- **Validation:** Validate required positional inputs in `main()` and fail fast with clear error messages.
- **Quoting:** Quote all variable expansions used in paths, tests, and command arguments.
- **Tests:** Prefer `[[ ... ]]` for tests and pattern matching.

## Code Quality

Apply these improvements only when explicitly requested; do not apply them outside the scope of the current task (see Output in General). Use these practices for new code and when refactoring existing code.

- **Unused Code:** Remove dead imports, unreachable code, unused variables, and unused functions.
- **DRY (Don't Repeat Yourself):** Extract duplicated logic into shared functions, utilities, or base classes.
- **Concurrency:** Improve threading and parallelization; adopt async/await patterns where applicable for I/O-bound operations.
- **Testing:** Create tests for significant functionality lacking coverage; prioritize critical paths, edge cases, and error conditions.
- **API/CLI Resilience:** Add exponential backoff, request batching, and rate limit handling to external calls to reduce timeout and rate limit failures.
- **Documentation:** Ensure `README.md` and code comments match the current implementation and reflect all documented behavior.
- **Type Hints:** Add or improve type annotations to enhance IDE support and enable early detection of type-related errors.
- **Dependencies:** Update to latest stable versions; remove deprecated or unused dependencies.
- **Error Handling:** Improve error messages and recovery strategies to aid debugging and user troubleshooting.
- **Complexity:** Reduce cyclomatic complexity by breaking large functions into smaller, focused units with single responsibilities.
- **Performance**: Profile to identify bottlenecks; optimize algorithms, data structures, and I/O; use caching strategically.

## External AI Chat

When creating prompts for external AI chat (ChatGPT, Gemini, etc.):

- **Source anchoring:** Every claime must map to a source file. Never fabricate or infer facts. Never soft-match or creatively paraphrase.
- **Step-by-step structure:** Break the task into numbered steps.
- **Output format rules:** Specify exact deliverable format (HTML code blocks, plain text blocks, etc.), styling, encoding, and any parser-specific constraints.
- **Content hygiene rules:** State non-negotiable rules upfront (e.g., "No fabrication", "No meta-commentary inside deliverables").
- **Analysis lives outside deliverables:** Analysis, rationale, and source citations belong in pre-output notes, not embedded in the final deliverable.
- **Stateless execution:** Instruct the AI to ignore its memory, prior conversations, and previous executions. Use only information supplied in the current prompt.
- **Deterministic validation:** Validate every non-deterministic AI response using deterministic checks (required sections, forbidden content checks, and rule assertions).
- **Warning behavior:** If validation detects prompt-instruction drift, emit a clear warning that lists each failed check. Warnings must include concise, concrete examples (expected vs actual, plus a suggested correction). Keep validation warnings outside the generated deliverable so the output format remains intact.
- **No automatic correction loop:** Validation warnings must not trigger retries, re-prompts, or execution failure by default. Retry or re-prompt only when the user or calling workflow explicitly asks for it.

## General

- Be concise. Skip conversational filler.
- If a task is trivial, provide solution without explanation.
- Do not use em dashes (—) or en dashes (–). Use hyphens or rewrite the sentence instead.

## Java & Spring Boot

- **Standards:** Use explicit types, descriptive names, and Checkstyle-compatible formatting.
- **Dependencies:** Standardize on Gradle for build management. Always use the Gradle Wrapper (`./gradlew`) for execution and tasks instead of calling `java` or `javac` directly.
- **Building:** Compile, test, and assemble artifacts with `./gradlew build`. README and similar docs should show `build` as the normal full build.
- **Run Command:** Configure projects so running the app uses a single command with no trailing file/class arguments (prefer `./gradlew run`).
- **Provisioning:** Utilize Java Toolchains in `build.gradle` to automate JDK provisioning and ensure environment isolation.
- **Structure:** Use a `src/` layout (`src/main/java`, `src/test/java`). Separate logic into controllers, services, repositories, and models.
- **Spring Utilization:** Only use Spring when creating web applications or using databases.
- **Spring Patterns:** Use Spring Boot auto-configuration, constructor injection, and focused `@RestController` classes. Prefer async handling for I/O bound operations.
- **Database:** Use Spring Data JPA with Hibernate and Flyway or Liquibase migrations. Keep DB logic separate from controllers.
- **Security:** Never build SQL with string concatenation; use parameter binding, repositories, or prepared statements.
- **Testing:** Use `JUnit 5` for all tests, with `Mockito` and `Spring Boot Test` where appropriate.
- **CLI Configuration:** Command line programs must not use command line arguments. Load configuration from environment variables only.

## JFreeChart

- **Version:** Use JFreeChart >= 1.5.x.
- **Aesthetics:** Always override default `StandardChartTheme`. Set chart and plot background to `Color.WHITE`. Set gridline colors to `F4F5F7`. Disable plot outlines. Remove legacy gradients/shadows. Start with the following series colors: Series 1 = `#0052CC`, Series 2 = `#00B8D9`, and Series 3 = `#FF8B00`. These default instructions can be overriden by `requirements.md`.
- **Headless:**: Always set `java.awt.headless=true` in task or main method.
- **Output:**: Prefer `ChartUtils.saveChartAsPNG` for file generation. Use `SVGGraphics2D` if vector output is requested.

## Jira

- **Experimental APIs:** Avoid experimental methods unless necessary; they may change without notice. If you use them, send the `X-ExperimentalApi` header to opt in and expect changes.
- **JQL Searches:** For JQL searches, use `/rest/api/3/search/jql`.
- **Expand:** Use the `expand` query parameter only when you need extra fields; over-expanding inflates responses and hurts performance.
- **Pagination:** For list endpoints, use `startAt`, `maxResults`, and `total` to size responses and iterate large datasets efficiently.
- **HTTP errors:** Handle standard status codes: 401 for auth failures, 403 for permission issues, and rate limiting; treat other failures gracefully.
- **Bulk operations:** Prefer bulk endpoints (e.g. `/rest/api/2/issue/bulk` for creating issues) instead of many single requests.
- **Validation:** Validate input on the client before sending requests to avoid 400 Bad Request responses.

## Local LLM

- **Runtime:** Use Ollama for all local LLM calls.
- **Model:** Use `llama3.2:3b` for local LLM execution.
- **Model freshness:** Before each project run, pull the model to ensure it is up to date (for example, `ollama pull llama3.2:3b`).
- **Status indicator:** When a local LLM is running, or when a project is waiting on a local LLM response, show a clear indicator in output or UI.
- **Structured output:** Enforce JSON responses at the API level (for example, Ollama `format="json"`).
- **Timeout floor:** Default local LLM request timeout should be at least 120 seconds on CPU-first environments.
- **Prompt budget:** Keep prompts compact.
- **Retry policy:** Retry only transient transport/service errors with bounded exponential backoff. Fail fast on non-retryable errors.
- **Operational diagnostics:** When troubleshooting, first verify Ollama reachability, loaded model list, timeout settings, and prompt size.
- **Example selection:** Use synthetic (fictional) examples in prompts, not real data from files.
- **Content separation:** Clearly label FORMAT EXAMPLE sections separate from ACTUAL DOCUMENT sections with explicit markers and instructions to analyze only the actual content.

## PowerShell

- **Scope:** Apply this style to new scripts and when refactoring existing scripts.
- **Strict Mode:** Include `Set-StrictMode -Version Latest` to catch uninitialized variables and property errors.
- **Error Handling:** Set `$ErrorActionPreference = 'Stop'` to ensure non-terminating errors are caught by try/catch blocks.
- **Naming Convention:** Use `PascalCase` for variables and `Verb-Noun` for function names using approved verbs.
- **Metadata:** Use the `[CmdletBinding()]` attribute for all functions to enable common parameters like `-Verbose` and `-ErrorAction`.
- **Script Directory:** Use the automatic variable `$PSScriptRoot` to reference the script location.
- **Parameters:** Define inputs within a `param()` block with explicit types and validation attributes (e.g., `[Parameter(Mandatory)]`, `[ValidateNotNullOrEmpty()]`).
- **Output:** Use `Write-Output` for data and `Write-Host` or `Write-Information` only for UI feedback. Avoid the `return` keyword unless necessary to exit early.
- **Pipeline:** Write functions that accept pipeline input using `process {}` blocks where applicable.
- **Entry Point:** Define a `Main` function or a primary block of logic and call it at the end of the script using `$args`.
- **Comparison:** Use PowerShell operators (e.g., `-eq`, `-ne`, `-match`) rather than bash-style symbols.

## Python & Flask

- **Standards:** Use type hints, descriptive names, and Ruff-compliant styling.
- **Dependencies:** Use `uv` for dependency management and virtual environments. Use `uv run`, `uv sync`, `uv lock`, and related `uv` commands instead of calling `python` or `pip` directly.
- **Run Command:** Configure projects so running the app uses a single command with no trailing file/module arguments (prefer `uv run <project>`).
- **Import Sorting:** Always include and use `isort` as the project import sorter. Keep `isort` installed in the project environment so IDE extensions use the project version and avoid interpreter errors.
- **Structure:** Use a `src/` layout. Separate logic into models, services, and utilities.
- **Flask Utilization:** Only use Flask when creating web applications or using databases.
- **Flask Patterns:** Use the Application Factory pattern and Blueprints. Prefer `async def` for I/O bound routes.
- **Database:** Use SQLAlchemy 2.0+ syntax and Flask-Migrate. Keep DB logic separate from routes.
- **Security:** Never use f-strings for SQL; use parameter substitution.
- **Testing:** Use `pytest` for all tests.
- **CLI Configuration:** Command line programs must not use command line arguments. Load configuration from environment variables only.

## Software Development

- **Git:** Respect `.gitignore`; exclude OS-specific and environment files from suggestions.
- **Output:** Scope every change to the requested task only, and do not add, edit, or remove unrelated code. Deliver edits in single chunks, avoid whitespace-only suggestions, and include the real code changes rather than only summarizing what would change.
- **Build Tool First:** For run/build/test/troubleshooting workflows, prefer project build tools and wrappers over calling language runtimes directly. Direct runtime calls are allowed only when troubleshooting the build tool itself, verifying runtime/toolchain state independently, or when the build tool is unavailable/broken. Assume the build tool is installed and available in the system PATH.
- **Run Command:** Set up projects so the normal execution path is one command with no extra target argument. Prefer wrapper/tool-native run commands (for example `./gradlew run` and `uv run <project>`). When a project has multiple runtime behaviors, choose behavior through environment variables (for example `APP_MODE=primary` or `APP_MODE=secondary`).
- **Environment:** Load variables from `.env`. Always update `.env.example`. Never hardcode secrets.
- **Context:** Don't ask to verify info visible in context or confirm provided instructions.
- **Documentation:** Maintain `README.md`. Use real file paths in links.
- **Requirements:**: Treat `requirements.md` as the authoritative specification but not as implementation details. It must remain complete enough for a developer to recreate the project from scratch (covering scope, features, behavior, criteria, architecture, and configuration). Update it alongside any code change that alters these elements.

## Your Instructions for Gemini

- Be concise and direct.
- Prioritize correctness over completeness.
- If a task is trivial, provide only the answer with no explanation.
- Do not fabricate, invent, assume, or speculate - state uncertainty when applicable.
- Do not rely on memory or prior chats.
- No inline or embedded links.
- No unnecessary verbosity, filler, or repetition.
- Do not use em dashes (—) or en dashes (–). Use hyphens or rewrite the sentence instead.
