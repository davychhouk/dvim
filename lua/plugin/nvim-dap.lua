return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "folke/snacks.nvim",
    "mason-org/mason.nvim",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "mfussenegger/nvim-dap-python",
    "mrcjkb/rustaceanvim",
  },
  -- stylua: ignore
  keys = {
    { "<leader>dc", function() require("dap").continue() end, mode = "n", desc = "Debug Start/Continue" },
    { "<leader>dsi", function() require("dap").step_into() end, mode = "n", desc = "Debug Step Into" },
    { "<leader>dso", function() require("dap").step_over() end, mode = "n", desc = "Debug Step Over" },
    { "<leader>dsu", function() require("dap").step_out() end, mode = "n", desc = "Debug Step Out" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, mode = "n", desc = "Debug Toggle Breakpoint" },
    { "<leader>dB" , function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, mode = "n", desc = "Debug Set Breakpoint" },
    { "<leader>dut", function() require("dapui").toggle() end, mode = "n", desc = "Debug UI Toggle" },
    { "<leader>dl", function() require("dap").run_last() end, mode = "n", desc = "Debug Run Last" },
  },
  -- stylua: ignore end
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local icons = require("util.icons").dap

    -- Install dap tools
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = {
        "codelldb",
        "delve",
      },
    })

    -- Setup icons
    local signs = {
      Stopped = { icons.STOPPED_POINT, "DiagnosticWarn", "DapStoppedLine" },
      Breakpoint = { icons.BREAKPOINT, "DiagnosticError" },
      BreakpointCondition = icons.BREAKPOINT_CONDITION,
      BreakpointRejected = { icons.BREAKPOINT_REJECTED, "DiagnosticError" },
      LogPoint = icons.LOG_POINT,
    }
    for name, sign in pairs(signs) do
      sign = type(sign) == "table" and sign or { sign }
      vim.fn.sign_define("Dap" .. name, {
        -- stylua: ignore
        text = sign[1] --[[@as string]] .. ' ',
        texthl = sign[2] or "DiagnosticInfo",
        linehl = sign[3],
        numhl = sign[3],
      })
    end

    -- Setup dapui
    ---@diagnostic disable-next-line: missing-fields
    dapui.setup({
      icons = {
        expanded = icons.EXPANDED,
        collapsed = icons.COLLAPSED,
        current_frame = icons.CURRENT_FRAME,
      },
      ---@diagnostic disable-next-line: missing-fields
      controls = {
        icons = {
          pause = icons.PAUSE,
          play = icons.PLAY,
          step_into = icons.STEP_INTO,
          step_over = icons.STEP_OVER,
          step_out = icons.STEP_OUT,
          step_back = icons.STEP_BACK,
          run_last = icons.RUN_LAST,
          terminate = icons.TERMINATE,
          disconnect = icons.DISCONNECT,
        },
      },
    })

    dap.listeners.before.attach.dapui_config = dapui.open
    dap.listeners.before.launch.dapui_config = dapui.open
    dap.listeners.before.event_terminated.dapui_config = dapui.close
    dap.listeners.before.event_exited.dapui_config = dapui.close

    -- Setup virtual text
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      virt_text_pos = "eol",
    })

    -- Python (via nvim-dap-python)
    -- "uv" tells dap-python to launch debugpy via `uv run --with debugpy`
    -- pythonPath auto-detected from VIRTUAL_ENV/CONDA_PREFIX via enrich_config
    require("dap-python").setup("uv")
    table.insert(dap.configurations.python, {
      type = "python",
      request = "launch",
      name = "FastAPI",
      module = "uvicorn",
      args = { "main:app", "--host", "0.0.0.0", "--port", "8000" },
    })
  end,
}
