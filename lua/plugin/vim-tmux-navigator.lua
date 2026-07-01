return {
  "christoomey/vim-tmux-navigator",
  event = "VeryLazy",
  config = function()
    local map = vim.keymap.set
    map("t", "<C-h>", "<C-\\><C-n><cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Navigate Left" })
    map("t", "<C-j>", "<C-\\><C-n><cmd>TmuxNavigateDown<cr>", { desc = "Tmux Navigate Down" })
    map("t", "<C-k>", "<C-\\><C-n><cmd>TmuxNavigateUp<cr>", { desc = "Tmux Navigate Up" })
    map("t", "<C-l>", "<C-\\><C-n><cmd>TmuxNavigateRight<cr>", { desc = "Tmux Navigate Right" })
  end,
}
