return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown", "vimwiki" },
  config = function()
    require("render-markdown").setup({
      enabled = true,
      render_modes = { "n" },
      max_file_size = 10.0,
      completions = {
        lsp = { enabled = true },
      },
    })
  end,
  keys = {
    {
      "<leader>mr",
      "<cmd>RenderMarkdown<cr>",
      mode = { "n" },
      desc = "Enable render markdown",
    },
    {
      "<leader>mt",
      "<cmd>RenderMarkdown toggle<cr>",
      mode = { "n" },
      desc = "Toggle render markdown",
    },
  },
}
