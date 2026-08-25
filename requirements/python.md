# Python

- `uv` used for env/deps/run.
- Toolchains; src/ layout used.
- Unless overridden by master requirements, Python logs to ./logs/<project_name>.log; overwritten on each run; no log output sent to stdout/stderr.
- Root source folder in snake_case containing __init__.py.
- [project.scripts] block in pyproject.toml mapping CLI command to entry function.
- Entry function inside target module accepts optional sequence arguments for testing while remaining zero-argument compatible with [project.scripts].
- Execution via uv run <project-name> triggers automatic env sync, binary mapping.
- `ruff` for formatting, import sorting, linting.
- `mypy` with --check-untyped-defs, --disallow-untyped-defs, --warn-return-any, and --no-implicit-optional enabled; full --strict omitted; Pydantic plugin enabled.
- `Protocol` (static duck typing) for interfaces; not abc. Protocols use @runtime_checkable if evaluated via isinstance at runtime.
- Frozen Pydantic v2 models for DTOs.
- Env vars via `Pydantic-Settings` for config, not CLI args; settings models may omit frozen=True exclusively to facilitate test-fixture overrides.
