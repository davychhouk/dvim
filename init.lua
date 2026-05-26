-- Bytecode cache
vim.loader.enable()

-- Leader mappings
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Core loading
require("core.lazy")
require("core.options")

-- Schedule secondaries
vim.schedule(function()
	require("core.mappings")
	require("config.snacks-toggle")
end)
