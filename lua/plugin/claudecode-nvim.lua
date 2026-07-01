return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  cmd = {
    "ClaudeCode",
    "ClaudeCodeFocus",
    "ClaudeCodeSend",
    "ClaudeCodeAdd",
    "ClaudeCodeDiffAccept",
    "ClaudeCodeDiffDeny",
  },
  opts = {
    -- Server Configuration
    port_range = { min = 10000, max = 65535 },
    auto_start = true,
    log_level = "info", -- "trace", "debug", "info", "warn", "error"
    terminal_cmd = nil, -- Custom terminal command (default: "claude")
    -- For local installations: "~/.claude/local/claude"
    -- For native binary: use output from 'which claude'

    -- Send/Focus Behavior
    -- When true, successful sends will focus the Claude terminal if already connected
    focus_after_send = false,

    -- Selection Tracking
    track_selection = true,
    visual_demotion_delay_ms = 50,

    -- Terminal Configuration
    ---@diagnostic disable-next-line: missing-fields
    terminal = {
      split_side = "right", -- "left" or "right"
      split_width_percentage = 0.375,
      provider = "auto", -- "auto", "snacks", "native", "external", "none", or custom provider table
      auto_close = true,
      snacks_win_opts = {}, -- Opts to pass to `Snacks.terminal.open()` - see Floating Window section below
      show_native_term_exit_tip = false,
      -- Provider-specific options
      provider_opts = {
        -- Command for external terminal provider. Can be:
        -- 1. String with %s placeholder: "alacritty -e %s" (backward compatible)
        -- 2. String with two %s placeholders: "alacritty --working-directory %s -e %s" (cwd, command)
        -- 3. Function returning command: function(cmd, env) return "alacritty -e " .. cmd end
        external_terminal_cmd = nil,
      },
    },
    -- Diff Integration
    diff_opts = {
      layout = "vertical", -- "vertical" or "horizontal"
      open_in_new_tab = true,
      keep_terminal_focus = false, -- If true, moves focus back to terminal after diff opens
      hide_terminal_in_new_tab = true,
      on_new_file_reject = "keep_empty", -- "keep_empty" or "close_window"
      -- Legacy aliases (still supported):
      -- vertical_split = true,
      -- open_in_current_tab = true,
    },
  },
  config = function(_, opts)
    require("claudecode").setup(opts)
    -- Fix: after C-h/C-l navigation, terminal pty gets stale dimensions;
    -- resend correct size so the TUI redraws to fill the window.
    vim.api.nvim_create_autocmd("WinEnter", {
      callback = function()
        local buf = vim.api.nvim_get_current_buf()
        if vim.bo[buf].buftype ~= "terminal" then
          return
        end
        vim.schedule(function()
          if not vim.api.nvim_buf_is_valid(buf) then
            return
          end
          local chan = vim.b[buf].terminal_job_id
          if not chan or chan <= 0 then
            return
          end
          local win = vim.api.nvim_get_current_win()
          if not vim.api.nvim_win_is_valid(win) then
            return
          end
          vim.fn.jobresize(chan, vim.api.nvim_win_get_width(win), vim.api.nvim_win_get_height(win))
        end)
      end,
    })
    -- Remap diff highlights per-side when claudecode opens a diff: red on old, green on new
    vim.api.nvim_create_autocmd("WinEnter", {
      group = vim.api.nvim_create_augroup("ClaudeCodeDiffHL", { clear = true }),
      callback = function()
        vim.schedule(function()
          local buf = vim.api.nvim_get_current_buf()
          if not vim.api.nvim_buf_is_valid(buf) then
            return
          end
          if not vim.b[buf].claudecode_diff_tab_name then
            return
          end
          if vim.b[buf]._diff_hl_applied then
            return
          end
          vim.b[buf]._diff_hl_applied = true

          -- Crash fix: render-markdown's buffer autocmd calls win_findbuf() on
          -- DiffUpdated/WinScrolled; during claudecode's new-tab :tabclose teardown
          -- that hits a freed window -> SIGSEGV in Neovim 0.12.x (markdown diffs only,
          -- e.g. spec.md/plan.md). Disabling it for the diff buffer makes the callback
          -- bail before win_findbuf. Drop once the upstream nvim win_findbuf fix lands.
          pcall(function()
            require("render-markdown").set_buf(false)
          end)

          local new_win = vim.api.nvim_get_current_win()
          vim.wo[new_win].winhighlight = "DiffChange:DiffChangeAdd,DiffText:DiffTextAdd"
          for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
            if w ~= new_win and vim.wo[w].diff then
              vim.wo[w].winhighlight = "DiffChange:DiffChangeDel,DiffText:DiffTextDel"
            end
          end

          -- After the diff tab closes, ensure the Claude terminal is visible AND focused.
          -- claudecode's own cleanup calls ensure_visible (no focus); we add the focus step.
          -- Avoid ClaudeCodeFocus — it's a toggle that can hide an already-visible terminal.
          vim.api.nvim_create_autocmd("WinClosed", {
            pattern = tostring(new_win),
            once = true,
            callback = function()
              vim.defer_fn(function()
                local ok, terminal = pcall(require, "claudecode.terminal")
                if not ok then
                  return
                end
                terminal.ensure_visible()
                local term_buf = terminal.get_active_terminal_bufnr()
                if not term_buf then
                  return
                end
                for _, w in ipairs(vim.api.nvim_list_wins()) do
                  if vim.api.nvim_win_get_buf(w) == term_buf then
                    vim.api.nvim_set_current_win(w)
                    if vim.bo[term_buf].buftype == "terminal" then
                      vim.cmd("startinsert")
                    end
                    return
                  end
                end
              end, 50)
            end,
          })
        end)
      end,
    })
  end,
	-- stylua: ignore start
	keys = {
		{ "<leader>cca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept Diff" },
		{ "<leader>ccb", "<cmd>ClaudeCodeAdd %<cr>", desc = "Add Current Buffer" },
		{ "<leader>ccc", "<cmd>ClaudeCode<cr>", desc = "Toggle Claude" },
		{ "<leader>ccC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
		{ "<leader>ccd", "<cmd>ClaudeCodeDiffDeny<cr>", desc = "Deny Diff" },
		{ "<leader>ccf", "<cmd>ClaudeCodeFocus<cr>", desc = "Focus Claude" },
		{ "<leader>ccr", "<cmd>ClaudeCode --resume<cr>", desc = "Resume Claude" },
		{ "<leader>ccs", "<cmd>ClaudeCodeSend<cr>", mode = "v", desc = "Send to Claude" },
	},
  -- stylua: ignore end
}
