return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  build = "make install_jsregexp",
  event = "VeryLazy",
  config = function()
    local ls = require("luasnip")

    ls.setup({
      history = true,
      update_events = "TextChanged,TextChangedI",
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
    })

    ls.filetype_extend("javascriptreact", { "javascript" })
    ls.filetype_extend("typescript", { "javascript" })
    ls.filetype_extend("typescriptreact", { "typescript" })

    -- Load friendly-snippets (VSCode format, ships with the plugin)
    require("luasnip.loaders.from_vscode").lazy_load()
    -- Load custom Lua-format snippets
    require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets" })
  end,
}
