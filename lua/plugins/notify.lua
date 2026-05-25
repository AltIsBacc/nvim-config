local M = {
	"rcarriga/nvim-notify",
	lazy = false,
	priority = 999,
}

function M.config()
	local notify = require("notify")

	notify.setup({
		stages = "slide",
		timeout = 3000,
		max_width = 40,
		max_height = 20,
		render = "wrapped-compact",
		top_down = true,
		background_colour = "#000000",
		icons = {
			ERROR = " ",
			WARN  = " ",
			INFO  = " 󰋼",
			DEBUG = " ",
			TRACE = " 󰙏",
		},
		
	})

	vim.notify = notify
end

return M
