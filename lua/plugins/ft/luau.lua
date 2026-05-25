-- Luau filetype plugin
-- luau-lsp.nvim is already a dependency of lsp.lua; this file just
-- wires up the treesitter integration for *.luau buffers.
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
