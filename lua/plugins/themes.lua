-- Extra themes — pre-installed, ready to switch
-- These are downloaded but not activated (Night Owl is default).
-- To use one, change the colorscheme command in colorscheme.lua

return {
  -- 🌊 Oceanic Next — deep ocean blue, calm, watery
  --    switch: vim.cmd.colorscheme("OceanicNext")
  {
    "mhartington/oceanic-next",
    lazy = true,
    init = function()
      vim.g.oceanic_next_terminal_bold = true
      vim.g.oceanic_next_terminal_italic = true
    end,
  },

  -- 🏔️  Nord — arctic blue, frosty, clean
  --    switch: vim.cmd.colorscheme("nord")
  {
    "shaunsingh/nord.nvim",
    lazy = true,
  },

  -- 🧋 Catppuccin Mocha — warm dark, cozy, popular
  --    switch: vim.cmd.colorscheme("catppuccin-mocha")
  --    or:    vim.cmd.colorscheme("catppuccin")  (requires setup call)
  {
    "catppuccin/nvim",
    lazy = true,
    name = "catppuccin",
  },

  -- 🌃 Tokyo Night — deep blue/purple night sky, vibrant
  --    switch: vim.cmd.colorscheme("tokyonight-night")
  --    variants: tokyonight-night, tokyonight-storm, tokyonight-day
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      style = "night",        -- "night" | "storm" | "day"
      transparent = false,
      styles = {
        comments = { italic = true },
        keywords = { bold = true },
      },
    },
  },

  -- 🏮 Kanagawa — dark ocean ink, inspired by japanese woodblock art
  --    switch: vim.cmd.colorscheme("kanagawa")
  --    variants: kanagawa, kanagawa-dragon, kanagawa-lotus
  {
    "rebelot/kanagawa.nvim",
    lazy = true,
  },
}
