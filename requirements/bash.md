# Bash Shell Scripting

- `#!/bin/bash`
- `set -o nounset`
- `set -o pipefail`
- `[[ "${TRACE-0}" = "1" ]] && set -o xtrace`
- Quoted expansions and `[[ ... ]]` are used.
- One `main()` entry point: `main "${@}"`.
