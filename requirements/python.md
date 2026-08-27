# Python

- Environment: uv using system PATH Python (python-version files forbidden); open-ended lower bounds in requires-python.
- Logging: Overwrite to ./logs/<project_name>.log per run; suppress stdout/stderr.
- Structure: src/ layout with snake_case root module (__init__.py). Expose CLI command via [project.scripts] in pyproject.toml pointing to entry function accepting optional sequence args (sys.argv compatible).
- Quality & Types: ruff (formatting/linting/imports); mypy with --check-untyped-defs, --disallow-untyped-defs, --warn-return-any, --no-implicit-optional, and pydantic plugin.
- Interfaces & Data: Use Protocol (not abc; add @runtime_checkable if evaluated via isinstance); frozen Pydantic v2 models for DTOs.
- Config: Env vars via Pydantic-Settings (unfrozen only if needed for test overrides), never CLI args.
