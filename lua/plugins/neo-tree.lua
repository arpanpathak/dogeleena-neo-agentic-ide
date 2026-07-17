return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    {
      "<leader>e",
      function()
        -- If already in neo-tree, close it (smart toggle)
        if vim.bo.filetype == "neo-tree" then
          vim.cmd("Neotree close")
          return
        end
        -- If a neo-tree window is already visible, focus it
        for _, winid in ipairs(vim.api.nvim_list_wins()) do
          local buf = vim.api.nvim_win_get_buf(winid)
          if vim.bo[buf].filetype == "neo-tree" then
            vim.api.nvim_set_current_win(winid)
            return
          end
        end
        -- Otherwise open the tree and focus it
        vim.cmd("Neotree reveal")
      end,
      desc = "File Explorer — Toggle/Focus",
      mode = "n",
    },
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
      },
    })
  end,
}
