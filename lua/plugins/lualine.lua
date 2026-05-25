local M = {
	"nvim-lualine/lualine.nvim",
	lazy = false,
	events = {
		"VimEnter",
		"InsertEnter",
		"BufReadPre",
		"BufAdd",
		"BufNew",
		"BufReadPost"
	},
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons"
		}
	}
}

function M.config()
	local ok, lualine = pcall(require, 'lualine')
	if not ok then return end

    local hide_in_width = function()
        return vim.fn.winwidth(0) > 80
    end

    local diagnostics = {
        "diagnostics",
        sources = { "nvim_diagnostic" },
        sections = { "error", "warn" },
        symbols = { error = " ", warn = " " },
        colored = true,
        always_visible = true
    }

    local diff = {
        "diff",
        colored = true,
        always_visible = false,
        symbols = { added = " ", modified = " ", removed = " " },
        cond = hide_in_width
    }

    local filetype = {
        "filetype",
        icons_enabled = true
    }

    local location = {
        "location",
        padding = 0
    }

    -- Show active LSP clients in statusline
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

    local indent = "indent: " .. vim.fn.shiftwidth()

    lualine.setup {
        options = {
            globalstatus = true,
            icons_enabled = true,
            theme = "auto",
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            disabled_filetypes = { "alpha", "dashboard" },
            always_divide_middle = true,
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = { "branch" },
            lualine_c = { diagnostics },
            lualine_x = { lsp_clients, diff, indent, "encoding", filetype },
            lualine_y = { location },
            lualine_z = { "progress" }
        }
    }
end

return M
