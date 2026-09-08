-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                         AI ASSISTANT                                      ║
-- ║           CodeCompanion.nvim — Multi-Provider AI Coding Agent            ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝
--
-- This plugin powers the AI chat, inline editing, and agentic coding features.
-- It supports ANY OpenAI-compatible API — see doc/AI.md for all providers.
--
-- SETUP: Set ONE of these environment variables before launching Neovim:
--
--   export OPENAI_API_KEY="sk-..."        # OpenAI
--   export ANTHROPIC_API_KEY="sk-ant-..." # Anthropic Claude
--   export DEEPSEEK_API_KEY="sk-..."      # DeepSeek
--   export GEMINI_API_KEY="..."           # Google Gemini
--   export OLLAMA_HOST="http://localhost:11434"  # Local Ollama
--   export OLLAMA_MODEL="qwen2.5-coder:7b"      # Optional: force an Ollama model
--   export OPENROUTER_API_KEY="sk-or-..." # OpenRouter (any model)
--
-- DEFAULT ADAPTER: The first available API key found determines the adapter.
-- Order checked: OpenAI → Anthropic → DeepSeek → Gemini → Ollama (local)
--
-- NOTE: @{agent} requires a model with function/tool calling. Dogeleena asks
-- Ollama which models can use tools and picks one at runtime; set OLLAMA_MODEL
-- to force a specific model.
--
-- USAGE:
--   <leader>ac  → Open chat (right sidebar)
--   <leader>aa  → Open chat (same, alias)
--   <leader>ae  → Code actions on selection (visual mode)
--   In chat: type @{agent} to activate agent tools for the conversation

-- ── Detect which AI provider to use ───────────────────────────────────────────
local ai_adapter = nil
local ai_env = {}

if os.getenv("OPENAI_API_KEY") then
  ai_adapter = "openai"
  ai_env = { api_key = os.getenv("OPENAI_API_KEY") }
elseif os.getenv("ANTHROPIC_API_KEY") then
  ai_adapter = "anthropic"
  ai_env = { api_key = os.getenv("ANTHROPIC_API_KEY") }
elseif os.getenv("DEEPSEEK_API_KEY") then
  ai_adapter = "deepseek"
  ai_env = { api_key = os.getenv("DEEPSEEK_API_KEY") }
elseif os.getenv("GEMINI_API_KEY") then
  ai_adapter = "gemini"
  ai_env = { api_key = os.getenv("GEMINI_API_KEY") }
elseif os.getenv("OPENROUTER_API_KEY") then
  ai_adapter = "openrouter"
  ai_env = { api_key = os.getenv("OPENROUTER_API_KEY") }
else
  -- Fall back to local Ollama if available (no API key needed)
  ai_adapter = "ollama"
end

-- Ollama model helper ---------------------------------------------------------
-- Don't hardcode model names. Ask the running Ollama server which models it has,
-- then pick the first one CodeCompanion resolves as tool-capable at runtime.
-- OLLAMA_MODEL can still force a specific model if the user wants one.
---@param adapter table
---@return string|nil
local function ollama_tool_model(adapter)
  local explicit = os.getenv("OLLAMA_MODEL")
  if explicit and explicit ~= "" then
    return explicit
  end

  local ok, get_models = pcall(require, "codecompanion.adapters.http.ollama.get_models")
  if not ok then
    return nil
  end

  local choices = get_models.choices(adapter, { async = false })
  if type(choices) ~= "table" then
    return nil
  end

  for name, choice in pairs(choices) do
    if choice and choice.opts and choice.opts.can_use_tools then
      return name
    end
  end

  return nil
end

return {
  "olimorris/codecompanion.nvim",
  tag = "v19.23.0", -- stable release; avoid nightly/main churn
  dependencies = {
    "nvim-lua/plenary.nvim",          -- Utility functions
    "nvim-treesitter/nvim-treesitter", -- Syntax parsing for AI diffs
  },
  -- Lazy-load keymaps — registered BEFORE config runs so Space+ac works everywhere
  keys = {
    { "<leader>ac", ":CodeCompanionChat<CR>", desc = "AI Chat", mode = "n" },
    { "<leader>aa", ":CodeCompanionChat<CR>", desc = "AI Chat", mode = "n" },
    { "<leader>ae", ":CodeCompanionActions<CR>", desc = "AI Actions", mode = "v" },
  },
  config = function()
    require("codecompanion").setup({
      -- ── Chat Window Layout ─────────────────────────────────────────────────
      display = {
        chat = {
          window = {
            layout = "vertical",  -- "vertical" | "horizontal" | "float"
            position = "right",   -- Chat opens on the right side
            width = 0.35,         -- 35% of screen width
            height = 0.5,         -- 50% of screen height (only for float/horizontal)
          },
        },
      },

      -- ── AI Adapters ─────────────────────────────────────────────────────────
      -- Each adapter is configured via environment variables for security.
      -- NEVER hardcode API keys here — use env vars!
      adapters = {
        http = {
          -- OpenAI (GPT-4o, GPT-4, etc.)
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = { api_key = os.getenv("OPENAI_API_KEY") or "" },
            })
          end,

          -- Anthropic Claude
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = { api_key = os.getenv("ANTHROPIC_API_KEY") or "" },
            })
          end,

          -- DeepSeek (V4, R1, etc.)
          deepseek = function()
            return require("codecompanion.adapters").extend("deepseek", {
              env = { api_key = os.getenv("DEEPSEEK_API_KEY") or "" },
            })
          end,

          -- Google Gemini
          gemini = function()
            return require("codecompanion.adapters").extend("gemini", {
              env = { api_key = os.getenv("GEMINI_API_KEY") or "" },
            })
          end,

          -- OpenRouter (unified API for any model)
          openrouter = function()
            return require("codecompanion.adapters").extend("openrouter", {
              env = { api_key = os.getenv("OPENROUTER_API_KEY") or "" },
            })
          end,

          -- Ollama (local, free, private)
          -- OLLAMA_HOST must include the scheme, e.g. http://localhost:11434
          ollama = function()
            local adapter = require("codecompanion.adapters").extend("ollama", {
              env = { url = os.getenv("OLLAMA_HOST") or "http://localhost:11434" },
            })

            -- Default to a tool-calling model so @{agent} actually edits/runs code.
            local default_model = adapter.schema.model.default
            adapter.schema.model.default = function(self)
              return ollama_tool_model(self)
                or (type(default_model) == "function" and default_model(self))
                or default_model
            end

            return adapter
          end,
        },
      },

      -- ── Interaction Strategies ──────────────────────────────────────────────
      -- NOTE: Do NOT use `strategies` key — in setup() it gets merged into
      -- `interactions` via tbl_deep_extend which WIPES existing `chat.tools`.
      -- Use `interactions` directly instead.
      interactions = {
        chat = {
          adapter = ai_adapter,    -- Chat panel uses detected adapter
          -- Agent tool group: type @{agent} to activate file/tool access.
          -- The built-in agent group already has its own strong agent system
          -- prompt and tool schemas; don't override it here.
          tools = {
            opts = {
              default_tools = { "agent" },
            },
          },
        },
        inline = { adapter = ai_adapter },  -- Inline editing uses same adapter
        agent = { adapter = ai_adapter },    -- Agent strategy uses same adapter
      },
    })

    -- ── Keymaps ───────────────────────────────────────────────────────────────
    -- Open AI Chat (right sidebar)
    vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>",
      { silent = true, desc = "AI Chat — Open" })
    vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionChat<CR>",
      { silent = true, desc = "AI Chat — Open (alias)" })

    -- AI Code Actions (visual mode: select code, then action)
    vim.keymap.set("v", "<leader>ae", "<cmd>CodeCompanionActions<CR>",
      { silent = true, desc = "AI Actions — on selection" })
  end,
}
