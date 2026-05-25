local M = {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	dependencies = {
		{ "nvim-tree/nvim-web-devicons" }
	}
}

function M.config()
	local ok, lualine = pcall(require, "lualine")
	if not ok then return end

	local hide_in_width = function()
		return vim.fn.winwidth(0) > 80
	end

	-- Mode with rounded pills (matching the screenshot)
	local mode = {
		"mode",
		fmt = function(str) return str end,
		separator = { left = "", right = "" },
		padding = { left = 1, right = 1 },
	}

	local diagnostics = {
		"diagnostics",
		sources = { "nvim_diagnostic" },
		sections = { "error", "warn" },
		symbols = { error = " ", warn = " " },
		colored = true,
		always_visible = false,
	}

	local diff = {
		"diff",
		colored = true,
		symbols = { added = " ", modified = " ", removed = " " },
		cond = hide_in_width,
	}

	-- Filename: just the name, no full path, with modified indicator
	local filename = {
		"filename",
		path = 1,           -- relative path, like the screenshot
		symbols = {
			modified = " ●",
			readonly = " ",
			unnamed  = "[No Name]",
		},
	}

	local lsp_clients = {
		function()
			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if #clients == 0 then return "" end
			local names = {}
			for _, c in ipairs(clients) do
				table.insert(names, c.name)
			end
			return "󰒍 " .. table.concat(names, ", ")
		end,
		cond = hide_in_width,
	}

	local filetype = {
		"filetype",
		icons_enabled = true,
		separator = { left = "", right = "" },
		padding = { left = 1, right = 1 },
	}

	local location = {
		"location",
		padding = { left = 1, right = 0 },
	}

	local progress = {
		"progress",
		padding = { left = 0, right = 1 },
	}

	lualine.setup({
		options = {
			globalstatus   = true,
			icons_enabled  = true,
			theme          = "auto",
			-- No powerline arrows between sections — clean like the screenshot
			component_separators = { left = "", right = "" },
			section_separators   = { left = "", right = "" },
			disabled_filetypes   = { "alpha", "dashboard" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { "branch", diff },
			lualine_c = { filename, diagnostics },
			lualine_x = { lsp_clients },
			lualine_y = { location, progress },
			lualine_z = { filetype },
		},
	})
end

return M
