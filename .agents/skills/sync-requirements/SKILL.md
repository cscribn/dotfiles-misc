---
name: sync-requirements
description: Use when requested to propagate uncommitted changes in master or linked requirement documents across code, tests, and docs, prioritizing human code readability.
---

# Sync Requirements

Propagate uncommitted specification changes from `requirements.md` and any linked requirement documents across core code, test suites, and documentation, prioritizing human code readability over cleverness or abstraction.

## Rules
* **Explicit Trigger Only:** Run only when directly invoked by name or explicit command.
* **Master & Linked Spec Traversal:** Audit `requirements.md` alongside any linked specification files for uncommitted git changes.
* **Diff First:** Execute `git diff -- requirements.md` and linked requirement files to extract all modified, added, or removed requirements before editing downstream files.
* **Plan Before Editing:** Map all affected core logic, test cases, and documentation files before applying changes.
* **Sync All Domains (Readability First):**
  - **Logic:** Simplify code. Avoid deep nesting, complex inheritance, and heavy abstractions. Favor clear, sequential, language-idiomatic structures with explicit naming and short explanatory comments.
  - **Tests & Docs:** Update existing tests/add coverage to reflect behavior changes instead of deleting or suppressing them. Keep tests simple so they act as readable usage examples. Keep docs aligned.
* **Verification:** Run affected tests after edits. Confirm code passes and is demonstrably easier to read before finalizing.

## Focus Areas
* **Specification Drift:** Discrepancies between updated requirements (in master or linked spec documents) and existing codebase behavior.
* **Broken Links & Cross-Refs:** Outdated paths or invalid references between `requirements.md` and any child requirement documents.
* **Test Alignment:** Stale tests asserting outdated constraints or missing assertions for newly introduced features.
* **Doc Staleness:** Outdated documentation reflecting retired requirements.
* **Code Clarity:** Unnecessary design patterns or clever one-liners that reduce readability.
