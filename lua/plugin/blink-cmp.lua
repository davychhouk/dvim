return {
  "saghen/blink.cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
    "disrupted/blink-cmp-conventional-commits",
    "ribru17/blink-cmp-spell",
  },
  version = "1.*",
  event = "InsertEnter",
  opts = function()
    return {
      appearance = {
        nerd_font_variant = "mono",
      },
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 500,
        },
        ghost_text = { enabled = true },
        menu = {
          draw = { components = require("config.blink-colors") },
        },
      },
      signature = { enabled = true },
      fuzzy = {
        implementation = "prefer_rust",
        sorts = { "exact", "score", "sort_text" },
      },
      keymap = { preset = "default" },
      snippets = { preset = "luasnip" },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
          "spell",
          "conventional_commits",
        },
        per_filetype = {
          lua = { inherit_defaults = true, "lazydev" },
        },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            score_offset = 100,
          },
          buffer = {
            opts = {
              get_bufnrs = function()
                return vim.tbl_filter(function(bufnr)
                  return vim.bo[bufnr].buftype == ""
                end, vim.api.nvim_list_bufs())
              end,
            },
          },
          conventional_commits = {
            name = "Conventional Commits",
            module = "blink-cmp-conventional-commits",
            enabled = function()
              return vim.bo.filetype == "gitcommit"
            end,
          },
          spell = {
            name = "Spell",
            module = "blink-cmp-spell",
            opts = { use_cmp_spell_sorting = true },
          },
        },
      },
    }
  end,
}
