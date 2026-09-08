-- ╔══════════════════════════════════════════════════════════════════════════════╗
-- ║                         EDITOR PLUGINS                                    ║
-- ║           Treesitter, Telescope                                           ║
-- ╚══════════════════════════════════════════════════════════════════════════════╝

return {
  -- ── Treesitter: Syntax Highlighting ─────────────────────────────────────────
  -- Uses current nvim-treesitter main (compatible with Neovim 0.12) instead of
  -- the old v0.9.x line, which uses the deprecated highlighter and can become
  -- unstable on Neovim 0.12.
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "5cb0114e6242625db56dd6440e945ed1ece10bc7",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      ts.setup({})

      -- Block on first install so Markdown parsers are ready before buffers open.
      local required_parsers = { "markdown", "markdown_inline" }
      local installed = ts.get_installed("parsers")
      local missing = vim.tbl_filter(function(lang)
        return not vim.tbl_contains(installed, lang)
      end, required_parsers)
      if #missing > 0 then
        local task = ts.install(missing)
        if task and task.pwait then
          task:pwait(60000)
        end
      end

      -- Use Neovim 0.12's native Treesitter highlighting instead of the old
      -- nvim-treesitter highlight module.
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "*",
        callback = function(args)
          pcall(vim.treesitter.start, args.buf)
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
}
