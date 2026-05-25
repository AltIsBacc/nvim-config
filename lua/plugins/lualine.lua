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
		padding = { left = 1, right = 1 },
	}

	local diagnostics = {
		function()
			local count = vim.diagnostic.count(0)
			local errors   = count[vim.diagnostic.severity.ERROR] or 0
			local warnings = count[vim.diagnostic.severity.WARN]  or 0
			local parts = {}
			if errors   > 0 then table.insert(parts, " " .. errors)   end
			if warnings > 0 then table.insert(parts, " " .. warnings) end
			return table.concat(parts, " ")
		end,
		color = function()
    		local count = vim.diagnostic.count(0)
    		local e = (count[vim.diagnostic.severity.ERROR] or 0) > 0
    		local w = (count[vim.diagnostic.severity.WARN] or 0) > 0

    		if e then return { fg = "#f44747" } end
    		if w then return { fg = "#ff8800" } end
    		return {}
		end,
		cond = hide_in_width,
	}

	local diff = {
		"diff",
		colored = true,
		symbols = { added = "  ", modified = "  ", removed = "  " },
		cond = hide_in_width,
	}

	-- Filename: just the name, no full path, with modified indicator
	local filename = {
		function()
        	local icons = {}

        	if vim.bo.modified then table.insert(icons, '●') end
        	if vim.bo.readonly then table.insert(icons, '') end
        	return table.concat(icons, ' ')
      	end,
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

	local location = {
		"location",
		padding = { left = 1, right = 1 },
	}

	local progress = {
		"progress",
		padding = { left = 1, right = 1 },
	}

	lualine.setup({
		options = {
			globalstatus   = true,
			icons_enabled  = true,
			theme          = "auto",
			section_separators   = { right = '', left = '' },
			component_separators = { right = '', left = '' },
			disabled_filetypes   = { "alpha", "dashboard" },
			always_divide_middle = true,
		},
		sections = {
			lualine_a = { mode },
			lualine_b = { "branch", diff },
			lualine_c = { filename },
			lualine_x = { diagnostics },
			lualine_y = { location, progress },
			lualine_z = { lsp_clients },
		},
	})
end

return M
