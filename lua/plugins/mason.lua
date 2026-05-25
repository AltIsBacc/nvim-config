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

	-- Flatten lang_servers: build ensure_installed, excluded, and skip servers
	-- whose binary is already present in PATH (Mason installed = left alone).
	local ensure_installed = {}
	local excluded = {}
	for _, entry in pairs(lang_settings.lang_servers) do
		local name
		local autostart  = true
		local executable = nil
		if type(entry) == "table" then
			name       = entry.name
			autostart  = entry.autostart ~= false
			executable = entry.executable
		else
			name = entry
		end

		-- Skip mason install if the server binary is already in PATH.
		-- `executable` field overrides the binary name when it differs from the server name.
		local bin = executable or name
		if vim.fn.executable(bin) == 1 then
			goto continue
		end

		table.insert(ensure_installed, name)

		::continue::
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
