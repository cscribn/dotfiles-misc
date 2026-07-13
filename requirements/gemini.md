# Gemini

## Gemini Prompts

- Gemini prompts are terse; bullets > paragraphs; fragments OK.
- Gemini prompts include response instructions: correct, not speculative; dashes okay, no em/en dashes; not unsolicited; one shot.

## Gemini Model

- Provider model‑list queried, IDs containing flash-lite filtered.
- Numeric <major>.<minor> extracted from each Flash‑Lite ID, sorted descending.
- Highest version = primary model; second‑highest = fallback.

## Gemini Usage

- Create Gemini client with `GOOGLE_API_KEY`.
- Call `models.generate_content(model=..., contents=prompt_text)` once per prompt, avoid exceeding quota.
- Graceful handling of Gemini HTTP responses: rate limits, service unavailable, auth/bad-request, empty/invalid output.
- Use `response.text`; fall back to `response.candidates[].content.parts[].text`
