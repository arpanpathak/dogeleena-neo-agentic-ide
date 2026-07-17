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

## Agent Mode

In AI chat (`<leader>ac`), type `@{agent}` to give AI file/tool access.

``` 
@{agent} Find where auth is defined and add rate limiting
```

## Inline Actions

Select code, press `<leader>ae`, then pick an action or type a prompt.
