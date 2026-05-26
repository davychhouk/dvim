local M = {}

local cache = { count = 0, refreshing = false }

local function refresh()
	if cache.refreshing then
		return
	end
	cache.refreshing = true
	vim.defer_fn(function()
		local ok, registry = pcall(require, "mason-registry")
		if not ok then
			cache.refreshing = false
			return
		end
		local count = 0
		for _, name in ipairs(registry.get_installed_package_names()) do
			local pkg = registry.get_package(name)
			if pkg then
				local ver = pkg:get_installed_version()
				local verRemote = pkg:get_latest_version()
				if ver and verRemote and ver ~= verRemote then
					count = count + 1
				end
			end
		end
		cache.count = count
		cache.refreshing = false
	end, 0)
end

-- refresh on mason registry update and once on first call
local initialized = false
local function ensure_init()
	if initialized then
		return
	end
	initialized = true
	-- defer first check so it doesn't block startup
	vim.defer_fn(function()
		local ok, registry = pcall(require, "mason-registry")
		if ok then
			registry:on("package:install:success", refresh)
			registry:on("package:uninstall:success", refresh)
		end
		refresh()
	end, 3000)
end

function M.updates()
	ensure_init()
	return cache.count
end

function M.has_updates()
	ensure_init()
	return cache.count > 0
end

return M
