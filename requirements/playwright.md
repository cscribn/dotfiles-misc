# Playwright

- Tooling & Execution: Standard call against `playwright.config.*`. `README.md` includes instructions on updating Playwright and browser binaries (`npx playwright install`).
- Structure: Flat test directory (`tests/`) mirroring features or user flows. Avoid deep Page Object Model inheritance hierarchies; use simple helper functions or lightweight page classes only when reuse is clear.
- Locators: Prefer user-facing locators (`getByRole`, `getByLabel`, `getByText`, `getByTestId`) over brittle CSS/XPath selectors.
- Synchronization: Rely on Playwright's built-in auto-waiting and web-first assertions (`await expect(locator).toBeVisible()`). Never use hardcoded sleeps (`waitForTimeout`).
- Isolation & State: Keep tests independent; authenticate once via `storageState` setup projects rather than logging in via UI before every test.
- Config & Environment: Read base URLs and credentials from env vars or `.env` with sensible local defaults.
- Diagnostics: Enable `trace: 'on-first-retry'`, `screenshot: 'only-on-failure'`, and `video: 'retain-on-failure'` in config for fast debugging without noisy artifacts.
- Formatting: Standard `prettier` formatting; prioritize test readability over DRY abstractions.
