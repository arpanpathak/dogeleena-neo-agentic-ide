-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                         AI ASSISTANT                                      ║
-- ║           CodeCompanion.nvim — Multi-Provider AI Coding Agent            ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝
--
-- This plugin powers the AI chat, inline editing, and agentic coding features.
--
-- SETUP: Set ONE of these environment variables before launching Neovim:
--
--   export OPENAI_API_KEY="sk-..."        # OpenAI
--   export ANTHROPIC_API_KEY="sk-ant-..." # Anthropic Claude
--   export DEEPSEEK_API_KEY="sk-..."      # DeepSeek
--   export GEMINI_API_KEY="..."           # Google Gemini
--   export OLLAMA_HOST="http://localhost:11434"  # Local Ollama
--   export OPENROUTER_API_KEY="sk-or-..." # OpenRouter (any model)
--
-- DEFAULT ADAPTER: The first available API key found determines the adapter.
-- Order checked: OpenAI → Anthropic → DeepSeek → Gemini → Ollama (local)
--
-- USAGE:
--   <leader>ac  → Open chat (right sidebar)
--   <leader>aa  → Open chat (same, alias)
--   <leader>ae  → Code actions on selection (visual mode)
--   In chat: type @{agent} to activate agent tools for that conversation only.
--
-- NOTE:
--   We intentionally do NOT auto-load @{agent} in every chat. That just burns
--   tokens with tool schemas/system prompts even when the model cannot use
--   tools. Let the built-in CodeCompanion defaults handle the agent group when
--   the user explicitly types @{agent}.

-- ── Detect which AI provider to use ───────────────────────────────────────────
local ai_adapter = nil

if os.getenv("OPENAI_API_KEY") then
  ai_adapter = "openai"
elseif os.getenv("ANTHROPIC_API_KEY") then
  ai_adapter = "anthropic"
elseif os.getenv("DEEPSEEK_API_KEY") then
  ai_adapter = "deepseek"
elseif os.getenv("GEMINI_API_KEY") then
  ai_adapter = "gemini"
elseif os.getenv("OPENROUTER_API_KEY") then
  ai_adapter = "openrouter"
else
  -- Fall back to local Ollama if available (no API key needed)
  ai_adapter = "ollama"
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
          -- OLLAMA_MODEL pins the model (use a tool-capable one for @{agent}).
          ollama = function()
            local adapter = require("codecompanion.adapters").extend("ollama", {
              env = { url = os.getenv("OLLAMA_HOST") or "http://localhost:11434" },
            })
            local model = os.getenv("OLLAMA_MODEL")
            if model and model ~= "" then
              adapter.schema.model.default = model
            end
            return adapter
          end,
        },
      },

      -- ── Interactions ────────────────────────────────────────────────────────
      -- NOTE: Do NOT use `strategies` key. Use `interactions` directly.
      -- Keep CodeCompanion's built-in tool/agent defaults.
      interactions = {
        chat = { adapter = ai_adapter },
        inline = { adapter = ai_adapter },
        agent = { adapter = ai_adapter },
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
