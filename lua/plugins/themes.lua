-- Extra themes — pre-installed, ready to switch
-- These are downloaded but not activated (Material Deep Ocean is default).
-- To use one, change the colorscheme command in colorscheme.lua

return {
  -- 🎀 Material Deep Ocean — the default (see colorscheme.lua for setup)
  --    switch: vim.g.material_style = "deep ocean"; vim.cmd.colorscheme("material")

  -- 🦉 Night Owl — dark, low contrast, long sessions
  --    switch: vim.cmd.colorscheme("night-owl")
  {
    "oxfist/night-owl.nvim",
    lazy = true,
  },

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

  -- 🌹 Rosé Pine — soft romantic dusk palette, easy on the eyes
  --    switch: vim.cmd.colorscheme("rose-pine")
  --    variants: rose-pine-moon, rose-pine-dawn
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = true,
  },

  -- 🌲 Everforest — warm green-based low-contrast theme for long sessions
  --    switch: vim.cmd.colorscheme("everforest")
  --    variants: dark/light + hard/medium/soft backgrounds
  {
    "sainnhe/everforest",
    lazy = true,
    init = function()
      vim.g.everforest_background = "soft"
      vim.g.everforest_enable_italic = true
    end,
  },
}
