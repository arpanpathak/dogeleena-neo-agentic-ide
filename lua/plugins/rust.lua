-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                      RUST LANGUAGE SUPPORT                                ║
-- ║           rustaceanvim — Full-featured Rust IDE experience               ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝
--
-- rustaceanvim manages rust-analyzer automatically — no separate install needed.
-- It provides: inlay hints, runnables, debugging (via nvim-dap), syntax tree,
-- macro expansion, and more.
--
-- REQUIREMENTS:
--   rustup (https://rustup.rs) — installs Rust + rust-analyzer

return {
  "mrcjkb/rustaceanvim",
  version = "^9",  -- Use v9.x (stable)
  lazy = false,    -- Load at startup
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Completion capabilities for nvim-cmp
  },
  config = function()
    vim.g.rustaceanvim = {
      server = {
        -- Wire completion capabilities so nvim-cmp gets suggestions from rust-analyzer
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          ["rust-analyzer"] = {
            inlayHints = {
              -- Disable visibility inlay hints ("pub") that show as white text
              visibility = { enable = false },
              -- Keep type hints but they'll be styled via LspInlayHint below
              typeHints = { enable = true },
              -- Disable closing brace hints (noisy)
              closingBraceHints = { enable = false },
            },
          },
        },
        on_attach = function(client, bufnr)
          local opts = { silent = true, buffer = bufnr }

          -- ═════════════════════════════════════════════════════════════════
          -- NAVIGATION
          -- ═════════════════════════════════════════════════════════════════
          -- Jump to definition (use Ctrl+o to jump back)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          -- Jump to implementation (goes to the actual impl, not just the trait)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          -- Find all references of the symbol under cursor
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)

          -- ═════════════════════════════════════════════════════════════════
          -- DOCUMENTATION
          -- ═════════════════════════════════════════════════════════════════
          -- Hover: type signature, docs, value
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          -- Signature help: function parameter hints while typing
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)

          -- ═════════════════════════════════════════════════════════════════
          -- REFACTORING & ACTIONS
          -- ═════════════════════════════════════════════════════════════════
          -- Code actions: auto-import, extract variable, add derive, etc.
          vim.keymap.set("n", "<leader>ca", vim.cmd.RustLsp("codeAction"), opts)
          -- Rename symbol project-wide (safe, updates all references)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          -- Show diagnostic details in a floating window
          vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, opts)

          -- ═════════════════════════════════════════════════════════════════
          -- STYLE: LspInlayHint — make inlay hints subtle & readable
          -- ═════════════════════════════════════════════════════════════════
          vim.api.nvim_set_hl(0, "LspInlayHint", {
            fg = "#5a5e6b",  -- subtle grey (works with both night-owl & tokyonight)
            italic = true,
          })
        end,
      },
    }
  end,
}
