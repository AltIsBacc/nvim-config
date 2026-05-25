local M = {
	"williamboman/mason.nvim",
	cmd = "Mason",
	event = "BufReadPre",
	dependencies = {
		{
			"williamboman/mason-lspconfig.nvim"
		}
	}
}

function M.config()
	require('mason').setup {
		ui = {
			border = "none",
			icons = {
				package_installed = "◍",
				package_pending = "◍",
				package_uninstalled = "◍",
			}
		},
		log_level = vim.log.levels.INFO,
		max_concurrent_installers = 4,
		PATH = "prepend"
	}

	local lang_settings = require('settings.languages')

	-- Flatten lang_servers to plain name strings for ensure_installed,
	-- and collect autostart=false servers for automatic_enable exclude
	local ensure_installed = {}
	local excluded = {}
	for _, entry in pairs(lang_settings.lang_servers) do
		local name
		local autostart = true
		if type(entry) == "table" then
			name      = entry.name
			autostart = entry.autostart ~= false
		else
			name = entry
		end
		table.insert(ensure_installed, name)
		if not autostart then
			table.insert(excluded, name)
		end
	end

	require('mason-lspconfig').setup {
		ensure_installed = ensure_installed,
		automatic_enable = {
			exclude = excluded,
		},
	}
end

return M
