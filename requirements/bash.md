# Bash Shell Scripting

- `#!/bin/bash`
- `set -o nounset`
- `set -o pipefail`
- `[[ "${TRACE-0}" = "1" ]] && set -o xtrace`
- Global variables are all caps and declared at top of file under settings.
- Quoted expansions and `[[ ... ]]` are used.
- One `main()` entry point: `main "${@}"`.
