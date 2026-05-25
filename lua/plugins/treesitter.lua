local M = {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	lazy = false,
	build = ':TSUpdate',
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons"
		},
	},
}

function M.config()
	if vim.bo.filetype == "luau" then
		require('luau-lsp').treesitter()
	end

	require('nvim-treesitter.configs').setup {
		ensure_installed = require('settings.languages').langs,
		highlight = {
			enable = true,
			disable = { "css" }
		},
		autopairs = {
			enable = true,
		},
		indent = {
			enable = true,
			disable = { "python", "css" }
		},
		sync_install = false
	}
end

return M
