-- Extra themes — pre-installed, ready to switch
-- These are downloaded but not activated (Night Owl is default).
-- To use one, change the colorscheme command in colorscheme.lua

-- 🦉 Night Owl (default) — dark, low contrast, eye-soothing
--    plugin: oxfist/night-owl.nvim
--    switch: vim.cmd.colorscheme("night-owl")

-- 🌊 Oceanic Next — deep ocean blue, calm, watery
return {
  "mhartington/oceanic-next",
  lazy = true,
  init = function()
    vim.g.oceanic_next_terminal_bold = true
    vim.g.oceanic_next_terminal_italic = true
  end,
}

-- 🏔️  Nord — arctic blue, frosty, clean
-- {
--   "shaunsingh/nord.nvim",
--   lazy = true,
-- }

-- 🧋 Catppuccin Mocha — warm dark, cozy, popular
-- {
--   "catppuccin/nvim",
--   lazy = true,
--   name = "catppuccin",
-- }
