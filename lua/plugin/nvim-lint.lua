return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("lint").linters_by_ft = {
      nix = { "statix" },
      lua = { "selene" },
      python = { "ruff" },
    }
    local grp = vim.api.nvim_create_augroup("nvim_lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
      group = grp,
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,
}
