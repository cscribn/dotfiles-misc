# Gemini

## Gemini Prompts

- Bullets > paragraphs; fragments OK.
- One instruction block; correctness > creativity; no speculation.
- Dashes OK; avoid em/en dashes.
- One-shot prompt/response; no unsolicited content.

## Gemini Model

- Query provider model list; filter Flash‑Lite IDs.
- Extract numeric version segments (major.minor.patch); missing minor/patch = 0.
- Sort descending; highest = primary; second‑highest = fallback.
- Auto‑fallback on repeated 429/503, empty‑candidate responses.

## Gemini Usage

- Create Gemini client with `GOOGLE_API_KEY`.
- Call `models.generate_content(model=..., contents=prompt_text)` once per prompt.
- Handle HTTP errors: 429 → exponential backoff, 503 → jittered retry, 400 → log prompt + model ID, 401/403 → re‑auth, 5xx → retry, Timeout → retry, Malformed JSON → retry, 200 OK + empty candidates → retry
- Response parsing: Use `response.text` if non‑empty. Else use first candidate’s first text part. Else return structured multimodal parts.
