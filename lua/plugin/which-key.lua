return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 25,
    spec = {
      -- buffers
      { "<leader>b", group = "buffer" },
      { "<leader>bc", group = "close" },
      { "<leader>bm", group = "move" },
      { "<leader>bt", group = "tab" },

      -- code
      { "<leader>c", group = "code" },
      { "<leader>cc", group = "claude" },

      -- debug
      { "<leader>d", group = "debug" },
      { "<leader>ds", group = "step" },
      { "<leader>du", group = "ui" },
      { "<leader>dv", group = "delta" },

      -- find
      { "<leader>f", group = "find" },

      -- git
      { "<leader>g", group = "git" },

      -- mason
      { "<leader>m", group = "mason" },

      -- neorg
      { "<leader>n", group = "neorg" },

      -- search / splits
      { "<leader>s", group = "search" },
      { "<leader>sp", group = "split" },
      { "<leader>ss", group = "lsp/plugin symbols" },

      -- session
      { "<leader>w", group = "session" },

      -- trouble
      { "<leader>t", group = "trouble" },

      -- ui / toggle
      { "<leader>u", group = "ui/toggle" },
    },
    filter = function(mapping)
      -- gc (comment operator) and <leader>cr (coerce motion) are intentional
      -- prefix+operator patterns; removing them from wk's tree prevents false
      -- overlap warnings while keeping the vim keymaps functional.
      local ignore = { "gc", " cr" }
      return not vim.tbl_contains(ignore, mapping.lhs)
    end,
  },
}
