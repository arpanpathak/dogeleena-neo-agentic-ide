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
        mapping_options = {
          noremap = true,
          nowait = true,
        },
        mappings = {},
      },
    })

    -- <leader>ac/aa on Neotree buffer via vim.keymap.set (string mappings
    -- in Neotree only work for builtin commands; "CodeCompanionChat" is not one)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "neo-tree",
      callback = function(args)
        vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat<CR>", {
          buffer = args.buf,
          desc = "AI Chat — Open",
        })
        vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionChat<CR>", {
          buffer = args.buf,
          desc = "AI Chat — Open (alias)",
        })
      end,
    })

    vim.keymap.set("n", "<leader>e", ":Neotree filesystem reveal left<CR>", {})
  end,
}
