return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "vimwiki" },
  config = function()
    require("render-markdown").setup({
      completions = {
        lsp = { enabled = true },
      },
      -- snacks.image renders mermaid blocks and math; leave them untouched
      code = { disable = { "mermaid" } },
      latex = { enabled = false },
    })
  end,
  keys = {
    {
      "<leader>mt",
      "<cmd>RenderMarkdown toggle<cr>",
      desc = "Toggle render markdown",
    },
  },
}
