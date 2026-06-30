-- Auto-open dashboard when last real buffer is closed
local grp = vim.api.nvim_create_augroup("snacks_auto_dashboard", { clear = true })

-- A tab page is "empty" when none of its windows show a real buffer
-- (listed and either named or modified).
local function cur_tab_is_empty()
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local b = vim.api.nvim_win_get_buf(w)
		if vim.bo[b].buflisted and (vim.api.nvim_buf_get_name(b) ~= "" or vim.bo[b].modified) then
			return false
		end
	end
	return true
end

-- Wipe the phantom [No Name] buffers Neovim creates when the last listed
-- buffer is deleted. Skip the dashboard itself. Deferred: the phantom may
-- not exist yet at call time.
local function wipe_phantom_buffers()
	vim.schedule(function()
		for _, b in ipairs(vim.api.nvim_list_bufs()) do
			if
				vim.api.nvim_buf_is_valid(b)
				and vim.bo[b].buflisted
				and vim.api.nvim_buf_get_name(b) == ""
				and not vim.bo[b].modified
				and vim.bo[b].filetype ~= "snacks_dashboard"
			then
				pcall(vim.api.nvim_buf_delete, b, {})
			end
		end
	end)
end

vim.api.nvim_create_autocmd({ "BufDelete", "BufWipeout" }, {
	group = grp,
	callback = function(args)
		-- Skip unlisted buffers (help, terminals, etc) — only react to user buffers
		if not vim.bo[args.buf].buflisted then
			return
		end
		-- Detach gitsigns so it doesn't leak state on the dying buffer
		pcall(function()
			require("gitsigns").detach(args.buf)
		end)
		-- Defer: BufDelete fires before the buffer is fully gone
		vim.schedule(function()
			-- Bail if Snacks isn't loaded yet
			-- selene: allow(global_usage)
			local snacks = rawget(_G, "Snacks")
			if not snacks then
				return
			end
			-- Already on dashboard, nothing to do
			if vim.bo.filetype == "snacks_dashboard" then
				return
			end
			-- With multiple tab pages, never open the dashboard. If the
			-- current tab is now empty, close it so Neovim switches to
			-- another tab page instead.
			if vim.fn.tabpagenr("$") > 1 then
				if cur_tab_is_empty() then
					pcall(vim.cmd.tabclose)
					wipe_phantom_buffers()
				end
				return
			end
			-- Look for any remaining "real" buffer (named or modified).
			-- If found, user still has work open — don't open dashboard.
			for _, b in ipairs(vim.api.nvim_list_bufs()) do
				if
					b ~= args.buf
					and vim.api.nvim_buf_is_valid(b)
					and vim.bo[b].buflisted
					and (vim.api.nvim_buf_get_name(b) ~= "" or vim.bo[b].modified)
				then
					return
				end
			end
			-- Sanity: current window must be valid and a normal buffer
			local win = vim.api.nvim_get_current_win()
			if not vim.api.nvim_win_is_valid(win) then
				return
			end
			if vim.bo.buftype ~= "" then
				return
			end
			-- Open dashboard in current window
			snacks.dashboard.open({ win = win })
			wipe_phantom_buffers()
		end)
	end,
})

-- Layout
local icons = require("util.icons")

-- ASCII "DVIM" banner shown at the top
local headerText = [[
██████╗ ██╗   ██╗██╗███╗   ███╗
██╔══██╗██║   ██║██║████╗ ████║
██║  ██║██║   ██║██║██╔████╔██║
██║  ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]]

-- Section blocks (each maps to one entry under `sections` below)
local header = {
	align = "center",
	text = { headerText, hl = "DashboardHeader" },
}

local separator = {
	align = "center",
	text = {
		"─────────────────────────────────────────────",
		hl = "DashboardHeader",
	},
}

local padding = { align = "center", text = { " " } }

-- Credit line: "Neovim + Snacks". Darwin drops the space because the
-- Snacks emoji renders wider on macOS terminals.
local nvim = icons.snacks.NVIM .. " eovim"
local snacksText = icons.snacks.SNACKS .. " Snacks"
---@diagnostic disable-next-line: undefined-field
if vim.uv.os_uname().sysname == "Darwin" then
	snacksText = icons.snacks.SNACKS .. "Snacks"
end
local credit = {
	align = "center",
	text = {
		{ nvim, hl = "DashboardCenter" },
		{ " + ", hl = "DashboardFooter" },
		{ snacksText, hl = "DashboardShortCut" },
	},
}

-- Built-in sections rendered by Snacks: keymap menu and startup time
local keys = { section = "keys", gap = 1 }

local startup = { icon = icons.snacks.ZAP, section = "startup" }

-- Config: returned to snacks.nvim as the `dashboard` opts table
return {
	width = 45,
	-- Quick-action menu shown on the dashboard
	preset = {
		-- stylua: ignore start
		keys = {
      { icon = icons.claude.CLAUDE,       key = "c", desc = "Claude Code",  action = ":ClaudeCode" },
      { icon = icons.snacks.EXPLORER,     key = "e", desc = "Explorer",     action = function() Snacks.explorer(require("config.snacks-explorer")) end },
			{ icon = icons.snacks.FIND_FILE,    key = "f", desc = "Find File",    action = function() Snacks.dashboard.pick("files") end },
      { icon = icons.snacks.LAZY,         key = "l", desc = "Lazy",         action = ":Lazy" },
			{ icon = icons.mason.MASON,         key = "m", desc = "Mason",        action = ":Mason" },
			{ icon = icons.snacks.QUIT,         key = "q", desc = "Quit",         action = ":qa" },
		},
		-- stylua: ignore end
	},
	-- Vertical render order: banner → credit → menu → startup time
	sections = {
		header,
		credit,
		padding,
		separator,
		padding,
		keys,
		padding,
		separator,
		startup,
	},
}
