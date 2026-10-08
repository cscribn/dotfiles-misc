# Python

- Environment: Standard `venv` with `pip` and `.python-version`. Pin versions for simple, predictable setups.
- Logging: Output directly to `stdout`/`stderr` using standard `logging` or print statements for instant visibility.
- Structure: Direct layout (`app.py` or simple modules) with a clear `main.py` entry point. Avoid `src/` boilerplate unless necessary.
- Quality & Format: Standard `ruff` or `black` formatting with generous line lengths. Use flexible linting/type checking—never block readability for strict rules.
- Data & Interfaces: Standard classes, `@dataclass`, or plain `dict` types. Avoid abstract protocols, heavy generic typing, and complex object hierarchies.
- Config: Load settings directly from `.env` or standard `config.py` with fallback defaults.
