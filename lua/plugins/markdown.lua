-- Markdown rendering for .md files.
-- CodeCompanion chat buffers are intentionally excluded for stability:
-- the extra rendering pass in chat buffers has caused redraw/terminal issues.
return {
  "MeanderingProgrammer/render-markdown.nvim",
  commit = "4663eb3ecd538bd5062628fb6d95bbe6bdca78f6",
  opts = {
    file_types = { "markdown" },
  },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
}
