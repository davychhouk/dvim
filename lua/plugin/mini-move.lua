return {
  "nvim-mini/mini.move",
  version = false,
  event = "VeryLazy",
  config = function()
    require("mini.move").setup()
  end,
}
