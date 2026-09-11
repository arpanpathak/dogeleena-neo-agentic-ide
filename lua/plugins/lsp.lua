-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                    LANGUAGE SERVERS (LSP)                                 ║
-- ║         Auto-completion, Go-to-definition, Diagnostics, Hover            ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝
--
-- LSP servers are automatically installed by Mason on first run.
-- No manual installation needed — just open a file and the server installs.
--
-- SUPPORTED LANGUAGES:
--   TypeScript/JavaScript  → ts_ls (typescript-language-server)
--   Python                 → pyright
--   C / C++                → clangd
--   Kotlin                 → kotlin-language-server
--   Java                   → jdtls (Eclipse JDT Language Server)
--   Rust                   → rust-analyzer (via rustaceanvim plugin)
--
-- KEYBINDINGS (buffer-local, active only when an LSP attaches):
--   gd          → Go to Definition
--   K           → Hover Documentation
--   <leader>rn  → Rename Symbol
--   <leader>ca  → Code Actions (auto-import, fix-its, extract)
--   <leader>de  → Diagnostic Details (floating window)

return {
  "neovim/nvim-lspconfig", -- Provides default configs for 200+ LSP servers
  dependencies = {
    "hrsh7th/nvim-cmp",          -- Completion engine
    "hrsh7th/cmp-nvim-lsp",      -- LSP source for completion
    "williamboman/mason.nvim",   -- LSP/DAP/linter installer
    "williamboman/mason-lspconfig.nvim", -- Bridge: Mason ↔ LSP configs
  },
  config = function()
    -- ═════════════════════════════════════════════════════════════════════════
    -- 0. DIAGNOSTICS — make errors readable (not just an "E" in the gutter)
    -- ═════════════════════════════════════════════════════════════════════════
    -- By default Neovim only draws the "E" sign in the sign column, so you get
    -- a line number and no idea what's wrong. This shows the message inline,
    -- underlines the offending code, and offers a popup.
    vim.diagnostic.config({
      virtual_text = { spacing = 2, prefix = "●" }, -- message at end of line
      signs = true,                                 -- the E/W/I gutter sign
      underline = true,                             -- highlight the bad token
      update_in_insert = false,                     -- don't flicker while typing
      severity_sort = true,                         -- errors before warnings
      float = { border = "rounded", source = true },
    })

    -- "Hover" an error: rest the cursor on the line and the full message pops
    -- up after `updatetime` (250ms). No keypress needed.
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        local bufnr = vim.api.nvim_get_current_buf()
        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
        if #vim.diagnostic.get(bufnr, { lnum = lnum }) > 0 then
          -- scope = "line" (not "cursor") so it works wherever the cursor sits
          -- on the line, not only when it is inside the error's exact range.
          vim.diagnostic.open_float(nil, { focus = false, scope = "line" })
        end
      end,
    })

    -- Manual controls (global, so they work even before an LSP attaches).
    vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float,
      { silent = true, desc = "Diagnostic — show error/warning under cursor" })
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist,
      { silent = true, desc = "Diagnostic — list all in location list" })
    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end,
      { silent = true, desc = "Diagnostic — previous" })
    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end,
      { silent = true, desc = "Diagnostic — next" })

    -- ═════════════════════════════════════════════════════════════════════════
    -- 1. MASON: Automatic LSP Installer
    -- ═════════════════════════════════════════════════════════════════════════
    -- Mason downloads and manages LSP server binaries.
    -- No npm/pip/cargo -g needed — Mason handles it all.
    require("mason").setup()

    -- Mason's clangd package does not support aarch64/ARM64. On those systems
    -- we keep the clangd server config below and use the distro's clangd.
    -- (vim.uv is the modern alias; vim.loop is deprecated.)
    local machine = vim.uv.os_uname().machine
    local is_arm64 = machine == "aarch64" or machine == "arm64"

    -- Auto-install these servers when they're needed (lazy install on demand)
    local ensure_installed = {
      "ts_ls",                   -- TypeScript / JavaScript
      "pyright",                 -- Python (Microsoft)
      "kotlin_language_server",  -- Kotlin
      "jdtls",                   -- Java (Eclipse JDT)
    }
    if not is_arm64 then
      table.insert(ensure_installed, "clangd") -- C / C++ (LLVM)
    end

    require("mason-lspconfig").setup({
      ensure_installed = ensure_installed,
      automatic_installation = true, -- Install missing servers automatically
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- 2. NVIM-CMP: Auto-completion Engine
    -- ═════════════════════════════════════════════════════════════════════════
    local cmp = require("cmp")
    cmp.setup({
      -- ── Completion Keymaps (in the completion menu) ──────────────────────
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),   -- Scroll docs up
        ["<C-f>"] = cmp.mapping.scroll_docs(4),    -- Scroll docs down
        ["<C-Space>"] = cmp.mapping.complete(),    -- Trigger completion
        ["<C-e>"] = cmp.mapping.abort(),           -- Cancel completion
        ["<CR>"] = cmp.mapping.confirm({            -- Accept selection
          select = true,                            -- Auto-select first item
        }),
      }),

      -- ── Completion Sources (order matters) ───────────────────────────────
      sources = cmp.config.sources({
        { name = "nvim_lsp" },  -- LSP completions (most accurate)
        { name = "buffer" },    -- Words from open buffers
        { name = "path" },      -- File path completions
      }),
    })

    -- ═════════════════════════════════════════════════════════════════════════
    -- 3. LSP SERVER CONFIGURATIONS
    -- ═════════════════════════════════════════════════════════════════════════
    -- We use Neovim's built-in vim.lsp.config (0.11+) instead of the
    -- deprecated require("lspconfig") to avoid deprecation warnings.
    -- Each server gets: cmd (binary), filetypes, root_markers (how to detect
    -- a project root), capabilities (completion features), and on_attach
    -- (buffer-local keymaps set when the server connects).

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Shared LSP keymaps, set when any LSP server attaches to a buffer.
    -- Keep in sync with doc/KEYBINDINGS.md and rust.lua's on_attach.
    local on_attach = function(client, bufnr)
      local function map(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end

      -- Navigation
      map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
      map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to Implementation")
      map("n", "gr", vim.lsp.buf.references, "LSP: Find References")

      -- Documentation / signatures
      map("n", "K", vim.lsp.buf.hover, "LSP: Hover Documentation")
      map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP: Signature Help")

      -- Refactoring
      map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Actions")
      map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename Symbol")

      -- Diagnostics (<leader>de, <leader>dl, [d, ]d) are global — see section 0.
    end

    local server_configs = {
      -- ── TypeScript / JavaScript ────────────────────────────────────────────
      ts_ls = {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        -- Detect project root by these files (in priority order)
        root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
      },

      -- ── Python ─────────────────────────────────────────────────────────────
      pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        root_markers = { "pyproject.toml", "setup.cfg", "setup.py", "requirements.txt", ".git" },
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,           -- Auto-detect venvs
              useLibraryCodeForTypes = true,    -- Infer types from libraries
              diagnosticMode = "openFilesOnly", -- Only check open files (faster)
            },
          },
        },
      },

      -- ── C / C++ ────────────────────────────────────────────────────────────
      clangd = {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        root_markers = { ".clangd", "compile_commands.json", ".git" },
        capabilities = vim.tbl_deep_extend("force", capabilities, {
          textDocument = { completion = { editsNearCursor = true } },
          offsetEncoding = { "utf-8", "utf-16" },
        }),
      },

      -- ── Kotlin ─────────────────────────────────────────────────────────────
      kotlin_language_server = {
        cmd = { "kotlin-language-server" },
        filetypes = { "kotlin" },
        root_markers = { "settings.gradle.kts", "settings.gradle", "build.gradle.kts", "build.gradle" },
        init_options = {
          -- Cache compiled project data for faster subsequent loads
          storagePath = vim.fn.getcwd(),
        },
      },

      -- ── Java ───────────────────────────────────────────────────────────────
      jdtls = {
        cmd = { "jdtls" },
        filetypes = { "java" },
        root_markers = { "gradlew", "mvnw", "settings.gradle", "settings.gradle.kts", ".git" },
      },
    }

    -- Apply all server configs and enable them
    for server, cfg in pairs(server_configs) do
      vim.lsp.config(server, vim.tbl_deep_extend("keep", cfg, {
        on_attach = on_attach,
        capabilities = cfg.capabilities or capabilities,
      }))
      vim.lsp.enable(server)
    end
  end,
}
