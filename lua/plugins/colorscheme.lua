return {
  "marko-cerovac/material.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- ── Material Deep Ocean — the default Dogeleena theme ────────────────────
    -- Deep blue-black ocean with cyan/blue accents. The stock Material "deep
    -- ocean" palette paints keywords/types purple (#C792EA), which reads as
    -- pink/magenta on some terminals. We remap any group still using that
    -- purple to the ocean-blue accent so it actually stays deep blue.
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

    local PURPLE = 0xC792EA
    local OCEAN_BLUE = 0x82AAFF

    local function apply_ocean_palette()
      -- Catches Treesitter/LSP groups too, not just the classic Vim names.
      for name, hl in pairs(vim.api.nvim_get_hl(0, {})) do
        if hl.fg == PURPLE then
          pcall(vim.api.nvim_set_hl, 0, name, { fg = OCEAN_BLUE })
        end
      end
      -- Some plugin-defined groups appear just after ColorScheme fires.
      for _, name in ipairs({ "LspCodeLens", "LspCodeLensSeparator", "SpellRare" }) do
        pcall(vim.api.nvim_set_hl, 0, name, { fg = OCEAN_BLUE })
      end
    end

    local function on_material()
      apply_ocean_palette()
      vim.defer_fn(apply_ocean_palette, 250)
    end

    -- Re-apply after every Material load, so toggling away and back also works.
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = { "material", "material-deep-ocean" },
      callback = on_material,
    })

    vim.cmd.colorscheme("material")
  end,
}
