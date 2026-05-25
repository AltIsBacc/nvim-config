local M = {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 999,
}

function M.config()
	local notify = require("notify")

	notify.setup({
		stages = "fade",
		timeout = 3000,
		max_width = 60,
		max_height = 10,
		render = "compact",
		top_down = false,
		background_colour = "#000000",
		icons = {
			ERROR = " ",
			WARN  = " ",
			INFO  = " ",
			DEBUG = " ",
			TRACE = "✎ ",
		},
	})

	-- Replace default vim.notify
	vim.notify = notify
end

return M
