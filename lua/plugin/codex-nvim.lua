return {
  "johnseth97/codex.nvim",
  cmd = { "Codex", "CodexToggle" },
  opts = {
    keymaps = {
      toggle = nil,
      quit = "<C-q>",
    },
    border = "rounded",
    width = 0.375,
    cmd = "codex",
    autoinstall = false,
    panel = true,
    use_buffer = false,
  },
  config = function(_, opts)
    require("codex").setup(opts)
    vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter", "TermOpen", "WinEnter" }, {
      group = vim.api.nvim_create_augroup("codex_start_insert", { clear = true }),
      callback = function()
        vim.schedule(function()
          local buf = vim.api.nvim_get_current_buf()
          if vim.bo[buf].filetype ~= "codex" or vim.bo[buf].buftype ~= "terminal" then
            return
          end
          vim.cmd("startinsert")
        end)
      end,
    })
  end,
  keys = {
    {
      "<leader>cx",
      "<cmd>CodexToggle<cr>",
      mode = { "n", "t" },
      desc = "Toggle Codex",
    },
  },
}
