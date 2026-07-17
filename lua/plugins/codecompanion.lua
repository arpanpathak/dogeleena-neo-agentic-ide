-- ~/.config/nvim/lua/plugins/codecompanion.lua
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("codecompanion").setup({
      display = {
        chat = {
          window = {
            layout = "vertical",
            position = "right",
            width = 0.35,
            height = 0.5,
          },
        },
      },
      adapters = {
        deepseek = function()
          return require("codecompanion.adapters").extend("deepseek", {
            env = {
              api_key = os.getenv("DEEPSEEK_API_KEY"),
            },
          })
        end,
      },
      strategies = {
        chat = { adapter = "deepseek" },
        inline = { adapter = "deepseek" },
        agent = { adapter = "deepseek" },
      },
    })

    vim.keymap.set("n", "<leader>ac", ":CodeCompanionChat<CR>", {})
    vim.keymap.set("v", "<leader>ae", ":CodeCompanionActions<CR>", {})
    vim.keymap.set("n", "<leader>aa", ":CodeCompanionChat<CR>", {})
  end,
}
