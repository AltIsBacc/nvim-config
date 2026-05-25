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
			border = "rounded",
			icons = {
				package_installed = "󰏓 ",
				package_pending = "󰏔 ",
				package_uninstalled = "󰏓 ",
			}
		},
		log_level = vim.log.levels.INFO,
		max_concurrent_installers = 4,
		PATH = "prepend"
	}

	local ensure_installed = {}
	local excluded = {}

	for _, server in ipairs(require('settings.languages').lang_servers) do
		if vim.fn.executable(server.executable or server.name) ~= 1 then
			table.insert(ensure_installed, server.name)
		end

		if not server.autostart then
			table.insert(excluded, server.name)
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
