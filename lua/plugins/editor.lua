-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                         EDITOR PLUGINS                                    ║
-- ║           File Explorer, Buffer Tabs, Treesitter, Markdown               ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

-- ═══════════════════════════════════════════════════════════════════════════════
-- 1. NEO-TREE: File Explorer (left sidebar)
-- ═══════════════════════════════════════════════════════════════════════════════
-- USAGE:
--   <leader>e  → Toggle file explorer (follows current file)
--   Inside tree: a (add file), d (delete), r (rename), m (move)
--   / (search), H (toggle hidden files), <CR> (open file)

return {
  -- ── File Explorer ───────────────────────────────────────────────────────────
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",          -- Utility library
      "MunifTanjim/nui.nvim",           -- UI component library
      "nvim-tree/nvim-web-devicons",    -- File icons (needs Nerd Font!)
    },
    config = function()
      -- Disable the built-in netrw (so neo-tree takes over)
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1

      require("neo-tree").setup({
        filesystem = {
          filtered_items = {
            visible = true,         -- Show hidden files
            hide_dotfiles = false,  -- Don't hide .dotfiles
            hide_gitignored = false, -- Show git-ignored files
          },
          follow_current_file = {
            enabled = true, -- Auto-highlight current file in tree
          },
        },
        window = {
          position = "left",
          width = 30,          -- 30 columns wide
        },
      })

      -- Toggle: opens focused on current file
      vim.keymap.set("n", "<leader>e", "<cmd>Neotree reveal<CR>",
        { silent = true, desc = "Explorer — Toggle" })
    end,
  },

  -- ── Buffer Tabs (top bar) ───────────────────────────────────────────────────
  -- USAGE:
  --   <leader>bn → Next buffer
  --   <leader>bp → Previous buffer
  --   <leader>bd → Close buffer
  --   <leader>b1 → Go to buffer #1 (use buffer number shown in tab)
  --   Left-click tab → Switch to buffer
  --   Middle-click tab → Close buffer
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup({
        options = {
          numbers = "ordinal",              -- Show ①, ②, ③… on tabs
          close_command = "bdelete! %d",    -- Middle-click closes buffer
          right_mouse_command = "bdelete! %d",
          left_mouse_command = "buffer %d", -- Left-click switches buffer
          indicator = { icon = "▎", style = "icon" },
          buffer_close_icon = "✕",
          modified_icon = "●",              -- ● means unsaved changes
          close_icon = "✕",
          max_name_length = 30,
          max_prefix_length = 30,
          diagnostics = "nvim_lsp",         -- Show LSP diagnostics on tabs
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              highlight = "Directory",
              text_align = "left",
            },
          },
          color_icons = true,
          show_buffer_icons = true,
          show_buffer_close_icons = true,
          persist_buffer_sort = true,
          always_show_bufferline = true,
        },
      })
    end,
  },

  -- ── Treesitter: Syntax Highlighting ─────────────────────────────────────────
  -- Provides rich syntax highlighting, code folding, and incremental selection.
  -- Auto-installs parsers for detected filetypes.
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.config").setup({})

      -- Enable treesitter-based features via Neovim built-in API
      vim.treesitter.highlighter.new = vim.treesitter.highlighter.new

      -- Request autocommand to install parsers on file open
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          pcall(function()
            require("nvim-treesitter.install").ensure(args.match)
          end)
        end,
      })
    end,
  },

  -- ── Telescope: Fuzzy Finder ─────────────────────────────────────────────────
  -- USAGE:
  --   <leader>ff → Find files
  --   <leader>fg → Live grep (search text)
  --   <leader>fr → Recent files
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files,
        { desc = "Telescope — Find Files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,
        { desc = "Telescope — Live Grep" })
      vim.keymap.set("n", "<leader>fr", builtin.oldfiles,
        { desc = "Telescope — Recent Files" })
    end,
  },

  -- ── Markdown Preview ────────────────────────────────────────────────────────
  -- Renders markdown with bold, italic, headings, code blocks, etc. in-buffer.
  -- Works in .md files AND in the AI chat window.
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {},
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}
