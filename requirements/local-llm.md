# Local LLM

- Runtime: Ollama only.
- Model: `llama3.2:3b` (pulled before run).
- JSON output enforced.
- Timeout >= 120s.
- Prompts < 500 tokens, synthetic examples only.
- Transient failures retried with bounded backoff.
