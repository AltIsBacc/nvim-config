local M = {
	'goolord/alpha-nvim',
	dependencies = {
		'nvim-tree/nvim-web-devicons'
	},
	lazy = false
}

function M.config()
	local alpha = require('alpha')
	local dashboard = require('alpha.themes.dashboard')

	-- ╔══════════════════════════════════════╗
	-- ║  Keep the original Neovim header     ║
	-- ╚══════════════════════════════════════╝
	dashboard.section.header.val = {
		[[                               __                ]],
		[[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
		[[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\ ]],
		[[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \]],
		[[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
		[[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
	}

	dashboard.section.header.opts = {
		hl = "AlphaHeader",
		position = "center",
	}

	-- ╔══════════════════════════════════════╗
	-- ║  Buttons                             ║
	-- ╚══════════════════════════════════════╝
	dashboard.section.buttons.val = {
		dashboard.button("f", "󰱽  Find file",       "<cmd>Telescope find_files<cr>"),
		dashboard.button("r", "  Recent files",     "<cmd>Telescope oldfiles<cr>"),
		dashboard.button("g", "  Live grep",        "<cmd>Telescope live_grep<cr>"),
		dashboard.button("n", "  New file",         "<cmd>ene <BAR> startinsert<cr>"),
		dashboard.button("l", "󰒲  Lazy",             "<cmd>Lazy<cr>"),
		dashboard.button("q", "  Quit",             "<cmd>qa<cr>"),
	}

	for _, btn in ipairs(dashboard.section.buttons.val) do
		btn.opts.hl        = "AlphaButton"
		btn.opts.hl_shortcut = "AlphaButtonShortcut"
	end

	-- ╔══════════════════════════════════════╗
	-- ║  Footer                              ║
	-- ╚══════════════════════════════════════╝
	local function footer()
		local stats = require("lazy").stats()
		local ms = math.floor(stats.startuptime)
		return string.format(
			"󱐌  %d plugins loaded in %d ms",
			stats.loaded, ms
		)
	end

	dashboard.section.footer.val = footer()
	dashboard.section.footer.opts = {
		hl = "AlphaFooter",
		position = "center",
	}

	-- ╔══════════════════════════════════════╗
	-- ║  Layout spacing                      ║
	-- ╚══════════════════════════════════════╝
	dashboard.config.layout = {
		{ type = "padding", val = 4 },
		dashboard.section.header,
		{ type = "padding", val = 3 },
		dashboard.section.buttons,
		{ type = "padding", val = 2 },
		dashboard.section.footer,
	}

	-- ╔══════════════════════════════════════╗
	-- ║  Highlights                          ║
	-- ╚══════════════════════════════════════╝
	-- Link to semantic groups so any colorscheme stays consistent:
	--   header   → Function  (bright accent, usually blue/purple)
	--   button   → Normal    (readable body text)
	--   shortcut → Type      (contrasting accent, often teal/green)
	--   footer   → Comment   (muted, inherits italic from most themes)
	local function set_highlights()
		vim.api.nvim_set_hl(0, "AlphaHeader",         { link = "Function" })
		vim.api.nvim_set_hl(0, "AlphaButton",         { link = "Normal" })
		vim.api.nvim_set_hl(0, "AlphaButtonShortcut", { link = "Type" })
		vim.api.nvim_set_hl(0, "AlphaFooter",         { link = "Comment" })
	end

	set_highlights()
	vim.api.nvim_create_autocmd("ColorScheme", { callback = set_highlights })

	alpha.setup(dashboard.config)
end

return M
