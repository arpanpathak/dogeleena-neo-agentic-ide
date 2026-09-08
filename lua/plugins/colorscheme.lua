return {
  "marko-cerovac/material.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    -- Material Deep Ocean — the default Dogeleena theme.
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
    vim.cmd.colorscheme("material")
  end,
}
