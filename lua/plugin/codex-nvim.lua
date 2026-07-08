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
    vim.api.nvim_create_autocmd({ "BufEnter", "TermEnter", "WinEnter" }, {
      group = vim.api.nvim_create_augroup("codex_scroll_bottom", { clear = true }),
      callback = function()
        vim.schedule(function()
          local win = vim.api.nvim_get_current_win()
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].filetype ~= "codex" then
            return
          end
          pcall(vim.api.nvim_win_set_cursor, win, { vim.api.nvim_buf_line_count(buf), 0 })
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
