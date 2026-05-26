local map = vim.keymap.set

-- Insert esc
map("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- Highlights
map("n", "<ESC>", "<CMD>noh<CR>", { desc = "Clear highlights" })

-- Redo <S-u>
map("n", "<S-u>", "<C-r>", { desc = "Redo", noremap = true, silent = true })

-- Replace
map("n", "<leader>rr", [[:%s/\<<C-r><C-w>\>//g<Left><Left>]], { desc = "Replace word under cursor" })

-- Select
map("n", "gG", "gg<S-v>G", { desc = "Select all" })

-- Window management
map("n", "<leader>sph", "<C-w>s", { desc = "Split window horizontally" })
map("n", "<leader>spv", "<C-w>v", { desc = "Split window vertically" })
map("n", "<leader>spe", "<C-w>=", { desc = "Make splits equal size" })
map("n", "<leader>spx", "<CMD>close<CR>", { desc = "Close current split" })

-- Yank
map("n", "<leader>yc", "yygccp", { desc = "Yank comment paste current line", remap = true })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- Quit
map("n", "<leader>Q", "<CMD>qa<CR>", { desc = "Quit all" })

-- Restart
map("n", "<leader>R", "<CMD>restart<CR>", { desc = "Restart Nvim" })

-- Health
map("n", "<leader>ch", "<CMD>checkhealth<CR>", { desc = "Checkhealth" })

-- Quickfix / loclist navigation
map("n", "]q", "<CMD>cnext<CR>", { desc = "Next quickfix item" })
map("n", "[q", "<CMD>cprev<CR>", { desc = "Prev quickfix item" })
map("n", "]l", "<CMD>lnext<CR>", { desc = "Next loclist item" })
map("n", "[l", "<CMD>lprev<CR>", { desc = "Prev loclist item" })
