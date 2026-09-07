---
name: code-reconcile
description: Strips dead code, slop, and defensive bloat while keeping requirements.md completely aligned with codebase behavior.
---

# Code Reconcile

Purge bloat and artifacts while ensuring code and requirements.md stay perfectly synchronized.

## Rules
* **Zero Behavior Changes:** Retain existing interfaces, outputs, and feature logic.
* **Delete, Don't Abstract:** Remove bloat without introducing new patterns or abstractions.
* **Sync Requirements:** Audit implemented feature logic against `requirements.md`. Add any implicit or missing requirements found in code, and remove references to purged features.
* **Verification:** Run tests after edits. Revert on failure.

## Target Artifacts
* **Slop:** Redundant/self-explanatory comments, defensive exception handling or guard clauses on internal paths, and explicit type-checker overrides.
* **Dead Code:** Unreferenced variables, imports, internal functions, unused exports, and unreachable branches.
* **Duplication:** Merge identical utility loops or helpers into canonical versions.
* **Documentation Drift:** Discrepancies between implemented code logic and `requirements.md`.
