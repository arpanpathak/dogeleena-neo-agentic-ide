-- Keep render-markdown off CodeCompanion chat buffers: the extra Treesitter
-- injection parsing there is what caused the recurring nil/redraw crashes.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  opts = {
    file_types = { "markdown" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
