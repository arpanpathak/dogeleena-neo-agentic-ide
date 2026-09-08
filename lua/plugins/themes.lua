-- Extra themes — pre-installed and always available
-- Night Owl is the default (see colorscheme.lua). These are not lazy-loaded so
-- `:colorscheme <Tab>` can list every theme.

return {
  -- 🎀 Material Deep Ocean — deep blue-black ocean with cyan/blue accents.
  -- The stock Material palette uses purple for keywords/types, which can look
  -- pink/magenta on some terminals; this spec remaps those groups to ocean
  -- blue/cyan so it stays deep blue.
  --    switch: vim.cmd.colorscheme("material")
  {
    "marko-cerovac/material.nvim",
    lazy = false,
    config = function()
      vim.g.material_style = "deep ocean"
      require("material").setup({
        contrast = {
          sidebars = true,
          floating_windows = true,
          cursor_line = true,
        },
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          types = { italic = true },
        },
      })
      -- Don't call :colorscheme here. Lazy auto-loads this plugin when the
      -- user runs `:colorscheme material`; applying it from inside config gets
      -- overwritten by the outer colorscheme command. Instead fix the palette
      -- after every Material ColorScheme event.
      local function apply_ocean_palette()
        -- Remap every remaining Material purple/pink group (#C792EA) to deep
        -- ocean blue. This catches Treesitter/LSP groups too, not just the
        -- classic Vim highlight names.
        local purple = 0xC792EA
        local ocean_blue = 0x82AAFF
        for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
          if hl.fg == purple then
            pcall(vim.api.nvim_set_hl, 0, name, { fg = ocean_blue })
          end
        end
        -- Some plugin-defined groups can appear just after ColorScheme fires.
        for _, name in ipairs({ "LspCodeLens", "LspCodeLensSeparator", "SpellRare" }) do
          pcall(vim.api.nvim_set_hl, 0, name, { fg = ocean_blue })
        end
      end

      local function on_material()
        apply_ocean_palette()
        vim.defer_fn(apply_ocean_palette, 250)
      end

      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = { "material", "material-deep-ocean" },
        callback = on_material,
      })
    end,
  },

  -- 🌊 Oceanic Next — deep ocean blue, calm, watery
  --    switch: vim.cmd.colorscheme("OceanicNext")
  {
    "mhartington/oceanic-next",
    lazy = false,
    init = function()
      vim.g.oceanic_next_terminal_bold = true
      vim.g.oceanic_next_terminal_italic = true
    end,
  },

  -- 🏔️  Nord — arctic blue, frosty, clean
  --    switch: vim.cmd.colorscheme("nord")
  {
    "shaunsingh/nord.nvim",
    lazy = false,
  },

  -- 🧋 Catppuccin Mocha — warm dark, cozy, popular
  --    switch: vim.cmd.colorscheme("catppuccin-mocha")
  --    or:    vim.cmd.colorscheme("catppuccin")  (requires setup call)
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
  },

  -- 🌃 Tokyo Night — deep blue/purple night sky, vibrant
  --    switch: vim.cmd.colorscheme("tokyonight-night")
  --    variants: tokyonight-night, tokyonight-storm, tokyonight-day
  {
    "folke/tokyonight.nvim",
    lazy = false,
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
    lazy = false,
  },

  -- 🌹 Rosé Pine — soft romantic dusk palette, easy on the eyes
  --    switch: vim.cmd.colorscheme("rose-pine")
  --    variants: rose-pine-moon, rose-pine-dawn
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
  },

  -- 🌲 Everforest — warm green-based low-contrast theme for long sessions
  --    switch: vim.cmd.colorscheme("everforest")
  --    variants: dark/light + hard/medium/soft backgrounds
  {
    "sainnhe/everforest",
    lazy = false,
    init = function()
      vim.g.everforest_background = "soft"
      vim.g.everforest_enable_italic = true
    end,
  },
}
