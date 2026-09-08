# AI Providers

Set one environment variable before launching Dogeleena.

| Provider | Env Variable | Models |
|----------|-------------|--------|
| Anthropic | `ANTHROPIC_API_KEY` | Claude Sonnet, Opus |
| OpenAI | `OPENAI_API_KEY` | GPT-4o, GPT-4, o1 |
| DeepSeek | `DEEPSEEK_API_KEY` | V4, V4 Pro, R1 |
| Gemini | `GEMINI_API_KEY` | Gemini 2.5 Pro |
| OpenRouter | `OPENROUTER_API_KEY` | Any model |
| Ollama | `OLLAMA_HOST` | Local (free) |

## Local Ollama

Yes, Dogeleena works with a local Ollama server. If no cloud API key is set,
Dogeleena automatically uses Ollama.

```bash
# Make sure Ollama is running locally
ollama serve

# Point Dogeleena at it (default is http://localhost:11434)
export OLLAMA_HOST="http://localhost:11434"

# Optional: force a specific Ollama model
export OLLAMA_MODEL="qwen2.5-coder:7b"

dogeleena
```

### Use a tool-capable model for @{agent}

`@{agent}` uses CodeCompanion's built-in tools (`read_file`, `create_file`,
`insert_edit_into_file`, `run_command`, etc.). That only works with models that
support **function/tool calling**.

Good Ollama choices are Qwen3.5, Qwen3, or Qwen2.5 (plain). Some local
`qwen2.5-coder` builds on Ollama print JSON/code blocks instead of making real
tool calls, so they do **not** work with `@{agent}`.

Dogeleena tries to pick a tool-capable Ollama model automatically. To force a
specific one, set `OLLAMA_MODEL` before launching:

```bash
export OLLAMA_MODEL="qwen3.5:latest"
dogeleena
```

To select a different model in-session:

1. Open AI chat with `<leader>ac`.
2. Press `ga` (change adapter).
3. Pick **Ollama** if it isn't already selected.
4. Pick the model you want — Dogeleena lists models pulled into your local Ollama server.

> If you don't see a model picker, check that Ollama is running and has models:
> ```bash
> ollama list
> ```

## Agent Mode

In AI chat (`<leader>ac`), type `@{agent}` to give AI file/tool access.

``` 
@{agent} Find where auth is defined and add rate limiting
```

## Inline Actions

Select code, press `<leader>ae`, then pick an action or type a prompt.
