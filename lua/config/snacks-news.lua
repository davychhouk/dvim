return {
  file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
  width = 0.6,
  height = 0.6,
  wo = {
    spell = false,
    wrap = false,
    signcolumn = "yes",
    conceallevel = 3,
  },
}
