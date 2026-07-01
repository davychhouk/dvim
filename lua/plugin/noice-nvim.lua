---@diagnostic disable: missing-fields
return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  config = function()
    require("noice").setup({
      -- snacks notifier owns vim.notify; noice's notify-view routing delegates to it
      notify = { enabled = false },
      lsp = {
        -- override markdown rendering
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = true,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      routes = {
        {
          view = "cmdline",
          filter = { event = "msg_showmode" },
        },
      },
      views = {
        cmdline_popup = {
          position = {
            row = "90%",
            col = "49.15%",
          },
          size = {
            width = "32%",
          },
        },
      },
    })
  end,
}
