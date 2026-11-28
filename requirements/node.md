# Node

## Shape

- Runbook layout: `'use strict'` (skip if ESM-only), top `require`, constants, `main().catch`; flow readable top-to-bottom.
- Direct Node APIs; no frameworks, DSLs, classes, plugin registries, or `runStep(kind, opts)` dispatch.
- Helpers only at 3+ repeats or one subprocess concern; ≤40 lines, explicit args, no shared mutable state.
- Tuning via file-top literals/env; one npm script per workflow; pin runtime deps.

## Paths

- User: `path.resolve`; repo assets: `path.join(__dirname, …)`; `fs.existsSync` before heavy work; errors cite paths.
- Large/generated text → files; pass paths on argv, not huge command lines.

## Child processes

- Long: `spawn` + stream stdio; short: `spawnSync`; inline options unless multiple call sites share one wrapper.
- Complete on child `exit` (brief drain if needed), not pipe `close` alone when grandchildren keep stdio.
- Timeouts: kill tree (POSIX process group; Windows `taskkill /T`); clear timers/handlers; forward `SIGINT`/`SIGTERM`; restore handlers after run.
- Windows + `shell: true`: quote argv tokens with spaces.

## Errors / deps

- No throws at module load; failures → log + `process.exitCode = 1`; tail-cap error text for repair loops; `node --check` before running agent output.
- Binary deps: pin + `require` (not PATH); gate OS-only APIs on `process.platform`; credentials via env; gitignore artifacts and local env files.
