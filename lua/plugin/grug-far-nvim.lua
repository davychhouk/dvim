return {
  "MagicDuck/grug-far.nvim",
  config = function()
    require("grug-far").setup({
      enabledReplacementInterpreters = { "default", "lua" },
      engines = {
        ripgrep = {
          showReplaceDiff = true,
        },
      },
    })
  end,
  keys = {
    {
      "<leader>grf",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n", "v" },
      desc = "Search and replace in opened file(s)",
    },
    {
      "<leader>grs",
      function()
        require("grug-far").open()
      end,
      mode = { "n", "v" },
      desc = "Search and replace",
    },
    {
      "<leader>grv",
      function()
        require("grug-far").open({ visualSelectionUsage = "operate-within-range" })
      end,
      mode = { "n", "v" },
      desc = "Search and replace within",
    },
    {
      "<leader>grw",
      function()
        require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
      end,
      mode = { "n" },
      desc = "Search word under cursor",
    },
  },
}
