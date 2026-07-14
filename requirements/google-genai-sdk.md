# Google Gen AI SDK

## Google Gen AI SDK Prompts

- Bullets > paragraphs; fragments OK.
- One instruction block; correctness > creativity; no speculation.
- Dashes OK; avoid em/en dashes.
- One-shot prompt/response; no unsolicited content.

## Google Gen AI SDK Client

- Client created with `GOOGLE_API_KEY`.
- `models.generate_content(model=..., contents=prompt_text)` called once per prompt.
- HTTP errors handled: 429 → exponential backoff, 503 → jittered retry, 400 → log prompt + model ID, 401/403 → re‑auth, 5xx → retry, Timeout → retry, Malformed JSON → retry, 200 OK + empty candidates → retry
- Response parsing: `response.text` used if non‑empty. Else first candidate’s first text part used. Else structured multimodal parts returned.
