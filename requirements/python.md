# Python

- `uv` used for env/deps/run.
- Toolchains; src/ layout used.
- `ruff` for formatting, import sorting, linting.
- `mypy`; --check-untyped-defs, --disallow-untyped-defs; no --strict.
- `Protocol` (static duck typing) for interfaces; not abc.
- Frozen Pydantic v2 models for DTOs.
- Env vars via `Pydantic-Settings` for config, not CLI args.
