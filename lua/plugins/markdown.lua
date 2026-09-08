-- Render markdown only in real .md files.
-- CodeCompanion chat buffers are intentionally excluded: the extra Treesitter
-- injection parsing there caused recurring nil/redraw crashes.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  commit = "4663eb3ecd538bd5062628fb6d95bbe6bdca78f6",
  ft = { "markdown" },
  opts = {
    file_types = { "markdown" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
