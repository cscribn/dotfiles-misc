# Bash Shell Scripting

- `#!/bin/bash`
- `set -o nounset`
- `set -o pipefail`
- `[[ "${TRACE-0}" = "1" ]] && set -o xtrace`
- Global variables: Top of file after settings, organized logically by purpose.
- Local variables: inside functions, declared with local at first use.
- Constants use `CONSTANT_CASE`; variables use `snake_case`.
- Quoted expansions and `[[ ... ]]` are used.
- One `main()` entry point: `main "${@}"`.
