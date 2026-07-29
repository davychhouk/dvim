return {
  "mason-org/mason.nvim",
  dependencies = {
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  cmd = { "Mason", "MasonUpdate" },
  event = "VeryLazy",
  config = function()
    local icons = require("util.icons").mason
    require("mason").setup({
      ui = {
        width = 0.8,
        height = 0.8,
        icons = {
          package_pending = icons.PENDING,
          package_installed = icons.INSTALLED,
          package_uninstalled = icons.UNINSTALLED,
        },
      },
    })

    require("mason-lspconfig").setup({
      automatic_enable = false,
      ensure_installed = {
        "azure_pipelines_ls",
        "bashls",
        "cssls",
        "gopls",
        "html",
        "lua_ls",
        "jsonls",
        "pyright",
        "tailwindcss",
        "taplo",
        "ts_ls",
        "yamlls",
        "zls",
      },
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "gofumpt",
        "goimports",
        "kdlfmt",
        "oxfmt",
        "oxlint",
        "prettierd",
        "ruff",
        "selene",
        "shellcheck",
        "shfmt",
        "statix",
        "stylua",
        "yamlfmt",
      },
    })
  end,
}
