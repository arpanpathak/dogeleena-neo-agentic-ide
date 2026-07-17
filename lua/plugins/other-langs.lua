return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls", "pyright", "clangd", "kotlin_language_server", "jdtls",
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          local on_attach = function(client, bufnr)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
          end

          -- Neovim 0.11+ API (vim.lsp.config)
          -- Falls back to legacy lspconfig API for older Neovim versions
          if vim.lsp and vim.lsp.config then
            vim.lsp.config[server_name] = {
              capabilities = capabilities,
              on_attach = on_attach,
            }
            vim.lsp.enable(server_name)
          else
            -- Legacy fallback for pre-0.11 Neovim
            local ok, lspconfig = pcall(require, "lspconfig")
            if ok then
              lspconfig[server_name].setup({
                on_attach = on_attach,
                capabilities = capabilities,
              })
            end
          end
        end,
      },
    })
  end,
}
