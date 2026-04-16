# Copilot Instructions

## General

- **Git:** Respect `.gitignore`; exclude OS-specific and environment files from suggestions.
- **Output:** Scope every change to the requested task only, and do not add, edit, or remove unrelated code. Deliver edits in single chunks, avoid whitespace-only suggestions, and include the real code changes rather than only summarizing what would change.
- **Environment:** Load variables from `.env`. Always update `.env.example`. Never hardcode secrets.
- **Context:** Don't ask to verify info visible in context or confirm provided instructions.
- **Documentation:** Maintain `README.md`. Use real file paths in links.
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

## External AI Chat

When creating prompts for external AI chat (ChatGPT, Gemini, etc.):

- **Source anchoring:** Every claime must map to a source file. Never fabricate or infer facts. Never soft-match or creatively paraphrase.
- **Evidence mapping:** Before the output, create an evidence map listing each planned claim and its supporting source snippet. Mark unsupported claims as `OMIT`.
- **Step-by-step structure:** Break the task into numbered steps. This helps AI reproducibility.
- **Output format rules:** Specify exact deliverable format (HTML code blocks, plain text blocks, etc.), styling, encoding, and any parser-specific constraints.
- **Content hygiene rules:** State non-negotiable rules upfront (e.g., "No fabrication", "No meta-commentary inside deliverables"). These override default AI behavior.
- **Analysis lives outside deliverables:** Analysis, rationale, and source citations belong in pre-output notes, not embedded in the final document.
- **Validation gate:** Include a pre-output checklist to verify all claims are evidence-backed and unsupported gaps are omitted, not soft-matched.

## Python & Flask

- **Standards:** Use type hints, descriptive names, and Ruff-compliant styling.
- **Dependencies:** Use `uv` for dependency management and virtual environments.
- **Structure:** Use a `src/` layout. Separate logic into models, services, and utilities.
- **Flask Patterns:** Use the Application Factory pattern and Blueprints. Prefer `async def` for I/O bound routes.
- **Database:** Use SQLAlchemy 2.0+ syntax and Flask-Migrate. Keep DB logic separate from routes.
- **Security:** Never use f-strings for SQL; use parameter substitution.
- **Testing:** Use `pytest` for all tests.

## Java & Spring Boot

- **Standards:** Use explicit types, descriptive names, and Checkstyle-compatible formatting.
- **Dependencies:** Use Maven Wrapper (`./mvnw`) for dependency management and consistent builds.
- **Structure:** Use a `src/` layout (`src/main/java`, `src/test/java`). Separate logic into controllers, services, repositories, and models.
- **Spring Patterns:** Use Spring Boot auto-configuration, constructor injection, and focused `@RestController` classes. Prefer async handling for I/O bound operations.
- **Database:** Use Spring Data JPA with Hibernate and Flyway or Liquibase migrations. Keep DB logic separate from controllers.
- **Security:** Never build SQL with string concatenation; use parameter binding, repositories, or prepared statements.
- **Testing:** Use `JUnit 5` for all tests, with `Mockito` and `Spring Boot Test` where appropriate.
