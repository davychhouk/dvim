return {
  "nvim-mini/mini.pairs",
  version = false,
  event = "InsertEnter",
  config = function()
    local pairs = require("mini.pairs")
    pairs.setup()

    -- Python triple quotes: the 3rd quote expands to a full docstring pair '''|'''
    -- (mini.pairs can't do multi-char pairs, so special-case the completing quote).
    local left3 = vim.api.nvim_replace_termcodes("<Left><Left><Left>", true, false, true)
    local triple = function(quote, neigh)
      return function()
        if vim.bo.filetype == "python" then
          local col = vim.fn.col(".")
          if vim.fn.getline("."):sub(col - 2, col - 1) == quote:rep(2) then
            return quote:rep(4) .. left3
          end
        end
        return pairs.closeopen(quote:rep(2), neigh)
      end
    end
    -- replace_keycodes=false: mini.pairs already returns raw termcodes.
    vim.keymap.set("i", "'", triple("'", "^[^%a\\]"), { expr = true, replace_keycodes = false })
    vim.keymap.set("i", '"', triple('"', "^[^\\]"), { expr = true, replace_keycodes = false })
  end,
}
