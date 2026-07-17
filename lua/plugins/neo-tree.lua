return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    require("neo-tree").setup({
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      window = {
        position = "left",
        width = 30,
        mappings = {
          ["<leader>ac"] = "CodeCompanionChat",
          ["<leader>aa"] = "CodeCompanionChat",
        },
      },
    })

    vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>", {})
  end,
}
