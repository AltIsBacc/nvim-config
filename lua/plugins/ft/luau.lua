local M = {
	"lopi-py/luau-lsp.nvim",
	ft = { "luau" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
}

function M.config()
	require("luau-lsp").treesitter()
end

return M
