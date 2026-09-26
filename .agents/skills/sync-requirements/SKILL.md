---
name: sync-requirements
description: Use strictly when explicitly requested to propagate uncommitted changes in master or linked requirement documents across code, tests, and docs.
---

# Sync Requirements

Propagate uncommitted specification changes from `requirements.md` and any linked requirement documents across core code, test suites, and documentation safely and systematically.

## Rules
* **Explicit Trigger Only:** Run only when directly invoked by name or explicit command.
* **Master & Linked Spec Traversal:** Audit `requirements.md` alongside any linked specification files for uncommitted git changes.
* **Diff First:** Execute `git diff -- requirements.md` and linked requirement files to extract all modified, added, or removed requirements before editing downstream files.
* **Plan Before Editing:** Map all affected core logic, test cases, and documentation files before applying changes.
* **Sync All Domains:** Update core logic to match new specs, adapt existing tests/add new coverage, and update documentation concurrently.
* **Verification:** Run affected tests after edits.

## Focus Areas
* **Specification Drift:** Discrepancies between updated requirements (in master or linked spec documents) and existing codebase behavior.
* **Broken Links & Cross-Refs:** Outdated paths or invalid references between `requirements.md` and any child requirement documents.
* **Test Alignment:** Stale tests asserting outdated constraints or missing assertions for newly introduced features.
* **Doc Staleness:** Outdated documentation reflecting retired requirements.
