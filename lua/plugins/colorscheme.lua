local M = {
	"ydkulks/cursor-dark.nvim",
	name = "cursor-dark",
	lazy = false,
	priority = 1000,
}

function M.config()
	require("cursor-dark").setup({
		style = "dark",
		transparent = false,
	})
end

return M
