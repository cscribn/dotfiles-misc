# Google Gen AI SDK

## Google Gen AI SDK Prompts

- Bullets > paragraphs; fragments OK.
- One instruction block; correctness > creativity; no speculation.
- Dashes OK; avoid em/en dashes.
- One-shot prompt/response; no unsolicited content.

## Google Gen AI SDK Client

- Client created with `GOOGLE_API_KEY`.
- `models.generate_content(model=..., contents=prompt_text)` retried up to configurable max attempts, with exponential delays from a retry base delay, capped at a retry max delay.
- Error handling: 429 → exponential backoff; 503 → jittered retry; other 5xx/408 → jittered retry; Timeout → jittered retry; Malformed JSON → jittered retry; 200 OK + empty candidates → jittered retry; 400 → log prompt + model ID, fail without retry; 401/403 → fail with re-auth guidance.
- Success returns `response.text` when non-empty; else candidate text parts joined; else empty-text error (retried).
- Retry notices go to stderr only when `JERBS_VERBOSE=true`; exhausted retries raise `RuntimeError` naming the last error.
- No model fallback: all attempts use the same model.
