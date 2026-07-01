return {
  "nvim-mini/mini.icons",
  version = false,
  lazy = true,
  opts = {
    -- Define your custom icons here (optional)
    -- file = { [".env"] = { glyph = "", hl = "MiniIconsYellow" } },
    -- filetype = { lua = { glyph = "", hl = "MiniIconsBlue" } },
    file = {
      ["LICENSE"] = { glyph = "󰿃", hl = "MiniIconsCyan" },
      ["LICENSE.md"] = { glyph = "󰿃", hl = "MiniIconsCyan" },
      ["LICENSE.txt"] = { glyph = "󰿃", hl = "MiniIconsCyan" },
    },
  },
  init = function()
    -- Mock nvim-web-devicons to use mini.icons
    package.preload["nvim-web-devicons"] = function()
      require("mini.icons").mock_nvim_web_devicons()
      return package.loaded["nvim-web-devicons"]
    end
  end,
}
