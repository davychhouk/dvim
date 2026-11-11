-- Common UI / option toggles via Snacks.toggle
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.zen():map("<leader>uz")
Snacks.toggle
  .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
  :map("<leader>uc")
-- Flags read by conform's format_on_save
-- stylua: ignore start
Snacks.toggle.new({
  id = "autoformat",
  name = "Autoformat",
  get = function() return not vim.g.disable_autoformat end,
  set = function(on) vim.g.disable_autoformat = not on end,
}):map("<leader>uf")
Snacks.toggle.new({
  id = "autoformat_buffer",
  name = "Autoformat (Buffer)",
  get = function() return not vim.b.disable_autoformat end,
  set = function(on) vim.b.disable_autoformat = not on end,
}):map("<leader>uF")
-- stylua: ignore end
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
