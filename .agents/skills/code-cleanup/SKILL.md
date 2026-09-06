---
name: code-cleanup
description: Strips dead code, slop, and defensive bloat without altering behavior.
---

# Code Cleanup

Purge bloat and artifacts while maintaining exact runtime behavior.

## Rules
* **Zero Behavior Changes:** Retain existing interfaces, outputs, and feature logic.
* **Delete, Don't Abstract:** Remove bloat without introducing new patterns or abstractions.
* **Verification:** Run tests after edits. Revert on failure.

## Target Artifacts
* **Slop:** Redundant/self-explanatory comments, defensive exception handling or guard clauses on internal paths, and explicit type-checker overrides.
* **Dead Code:** Unreferenced variables, imports, internal functions, unused exports, and unreachable branches.
* **Duplication:** Merge identical utility loops or helpers into canonical versions.
