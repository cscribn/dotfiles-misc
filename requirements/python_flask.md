# Python

- `uv` used for env/deps/run.
- Toolchains; src/ layout used.
- ruff for formatting, import sorting, linting.
- mypy; --check-untyped-defs, --disallow-untyped-defs; no --strict.typing.
- Protocol (static duck typing) for interfaces; not abc.
- Frozen Pydantic v2 models for DTOs.
- FastAPI for routing (utilizing Depends for injection).
- Concerns separated (Routes → Services → SQLAlchemy 2.0 typed mappings).
- Env vars via Pydantic-Settings for config.
