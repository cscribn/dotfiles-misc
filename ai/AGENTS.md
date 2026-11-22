# Agent Instructions

- Correctness first; no speculation; state uncertainty. No em/en dashes.
- Update project as prompted; no unsolicited changes.
- `requirements.md` is authoritative; follow all paths/links; ask on conflicts.
- Update docs whenever code changes impact behavior, APIs, requirements.
- Terse; bullets > paragraphs; fragments OK; exact technical terms.
- Verification: always use project-local sandbox for write operations.
- Sub-agents: delegate noisy read-only discovery/logs (return summaries/paths); parallelize disjoint write scopes only; skip for <3-step/single-file tasks; verify 4+ file diffs via separate sub-agent.
