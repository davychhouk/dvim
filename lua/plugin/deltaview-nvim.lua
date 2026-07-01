return {
  "kokusenz/deltaview.nvim",
  cmd = { "DeltaView", "DeltaMenu", "Delta" },
  keys = {
    { "<leader>dvm", "<CMD>DeltaMenu<CR>", desc = "Toggle DeltaMenu" },
    { "<leader>dvl", "<CMD>DeltaView<CR>", desc = "Toggle DeltaView" },
    { "<leader>dva", "<CMD>Delta<CR>", desc = "Toggle Delta" },
  },
  config = function()
    require("delta").setup({})
    require("deltaview").setup({
      use_nerdfonts = true,
      line_numbers = true,
      keyconfig = {
        dm_toggle_keybind = "<leader>dvm",
        dv_toggle_keybind = "<leader>dvl",
        d_toggle_keybind = "<leader>dva",
        next_hunk = "<Tab>",
        prev_hunk = "<S-Tab>",
        next_diff = "]f",
        prev_diff = "[f",
        fzf_toggle = "alt-;",
        help_legend = "d?",
      },
    })
  end,
}
