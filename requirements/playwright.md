# Playwright

## Shape

- One async entry; chapters = top-to-bottom `await` steps; constants (paths, viewport) at top.
- Direct Playwright calls; no Page Objects, fixtures, scenario builders, or custom click/wait wrappers.
- Locators inline or `const x = page.getByRole(…)` per chapter; `.filter()`/chain, not selector maps.
- Helpers only at 3+ repeats; name by behavior (`dismissPopovers`), not layers (`PageActions`).
- `addInitScript`/HUD: same-file string or small inline function; single file unless repo already splits modules.

## Setup

- Pin `playwright`; `npx playwright install` only browsers used; CI cache or install browsers; fail if missing.

## Actions

- `getByRole` / `getByLabel` / `getByText` > CSS/XPath; one target per action; explicit `{ timeout }` on click/fill/wait.
- Assert or `waitFor*` for readiness; `waitForTimeout` only for animation/pacing, not blind sync.
- `file:` pages: `waitUntil: "load"` or DOM-stable wait; avoid `networkidle` unless network truly idle.
- `page.goto(pathToFileURL(absolutePath).href)`; not bare filesystem paths.
- Strict: one visible match; stable UI before/after; no races with timers, autoplay, or transient controls; serial `await`, no `Promise.all` on UI.

## Lifecycle / recording

- `let browser, context, page`; `try/finally` in walkthrough file; teardown: stop record/trace → save artifacts → `context.close()` → `browser.close()`; each step try/catch (log, continue).
- One of `recordVideo` or screencast per context, not both; match viewport to encode size.
- Probes: process timeout, `browser.close()` in `finally`, foreground, explicit exit.

## Output

- Match repo CJS/ESM; no markdown fences in `.js`; throwaway probes vs idempotent production scripts; no config-driven step lists.
