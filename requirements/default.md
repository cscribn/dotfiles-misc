# Default requirements

## Project

- One run command; env vars used for runtime modes.
- Config loads from .env; .env.example kept synced; secrets never hardcoded; .gitignore maitained for artifacts, secrets, local env.
- README.md as operator guide (build/run/env), not as requirements; README, requirements.md kept in sync with behavior/config changes.

## Quality

- Prioritize YAGNI, reuse (codebase/stdlib/platform/deps); write minimum required code only if one-line solution doesn't exist.
- Abstraction is never premature; repeated logic extracted after appearing 3+ times.
- Functions kept small, cohesive (<= 40 lines, low complexity); explicit types used over generic open-ended configs.
- Dead code removed, no unused imports.
- Tests kept up to date with behavior; error messages are actionable.
