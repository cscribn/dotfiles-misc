# Agent Instructions/Rules

## General

- **Git:** Respect `.gitignore`; exclude OS-specific and environment files from suggestions.
- **Output:** Scope every change to the requested task only, and do not add, edit, or remove unrelated code. Deliver edits in single chunks, avoid whitespace-only suggestions, and include the real code changes rather than only summarizing what would change.
- **Environment:** Load variables from `.env`. Always update `.env.example`. Never hardcode secrets.
- **Context:** Don't ask to verify info visible in context or confirm provided instructions.
- **Documentation:** Maintain `README.md`. Use real file paths in links.
- **Requirements:** Keep `requirements.md` aligned with the product: whenever you change code that affects documented behavior, scope, user-visible flows, or acceptance criteria, update `requirements.md` in the same change so it stays accurate.
- **Punctuation:** Do not use em dashes (—) or en dashes (–). Use hyphens or rewrite the sentence instead.

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

## Behavior

- Be concise. Skip conversational filler.
- If a task is trivial, provide code without explanation.

## Code Quality

Apply these improvements only when explicitly requested; do not apply them outside the scope of the current task (see Output in General). Use these practices for new code and when refactoring existing code.

- **Unused Code:** Remove dead imports, unreachable code, unused variables, and unused functions.
- **DRY (Don't Repeat Yourself):** Extract duplicated logic into shared functions, utilities, or base classes.
- **Concurrency:** Improve threading and parallelization; adopt async/await patterns where applicable for I/O-bound operations.
- **Testing:** Create tests for significant functionality lacking coverage; prioritize critical paths, edge cases, and error conditions.
- **API/CLI Resilience:** Add exponential backoff, request batching, and rate limit handling to external calls to reduce timeout and rate limit failures.
- **Documentation:** Ensure `README.md`, code comments, and `requirements.md` match the current implementation and reflect all documented behavior.
- **Type Hints:** Add or improve type annotations to enhance IDE support and enable early detection of type-related errors.
- **Dependencies:** Update to latest stable versions; remove deprecated or unused dependencies.
- **Error Handling:** Improve error messages and recovery strategies to aid debugging and user troubleshooting.
- **Complexity:** Reduce cyclomatic complexity by breaking large functions into smaller, focused units with single responsibilities.
- **Performance**: Profile to identify bottlenecks; optimize algorithms, data structures, and I/O; use caching strategically.

## External AI Chat

When creating prompts for external AI chat (ChatGPT, Gemini, etc.):

- **Source anchoring:** Every claime must map to a source file. Never fabricate or infer facts. Never soft-match or creatively paraphrase.
- **Evidence mapping:** Before the output, create an evidence map listing each planned claim and its supporting source snippet. Mark unsupported claims as `OMIT`.
- **Step-by-step structure:** Break the task into numbered steps. This helps AI reproducibility.
- **Output format rules:** Specify exact deliverable format (HTML code blocks, plain text blocks, etc.), styling, encoding, and any parser-specific constraints.
- **Content hygiene rules:** State non-negotiable rules upfront (e.g., "No fabrication", "No meta-commentary inside deliverables"). These override default AI behavior.
- **Analysis lives outside deliverables:** Analysis, rationale, and source citations belong in pre-output notes, not embedded in the final document.
- **Validation gate:** Include a pre-output checklist to verify all claims are evidence-backed and unsupported gaps are omitted, not soft-matched.

## Java & Spring Boot

- **Standards:** Use explicit types, descriptive names, and Checkstyle-compatible formatting.
- **Dependencies:** Standardize on Gradle for build management; always use the Gradle Wrapper (`./gradlew`) for execution.
- **Building:** Compile, test, and assemble artifacts with `./gradlew build`. README and similar docs should show `build` as the normal full build.
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

## Python & Flask

- **Standards:** Use type hints, descriptive names, and Ruff-compliant styling.
- **Dependencies:** Use `uv` for dependency management and virtual environments.
- **Structure:** Use a `src/` layout. Separate logic into models, services, and utilities.
- **Flask Utilization:** Only use Flask when creating web applications or using databases.
- **Flask Patterns:** Use the Application Factory pattern and Blueprints. Prefer `async def` for I/O bound routes.
- **Database:** Use SQLAlchemy 2.0+ syntax and Flask-Migrate. Keep DB logic separate from routes.
- **Security:** Never use f-strings for SQL; use parameter substitution.
- **Testing:** Use `pytest` for all tests.
- **CLI Configuration:** Command line programs must not use command line arguments. Load configuration from environment variables only.
