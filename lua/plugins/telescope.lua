local M = {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>",  desc = "Find Files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>",   desc = "Live Grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>",     desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>",   desc = "Help Tags" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>",    desc = "Recent Files" },
		{ "<leader>fs", "<cmd>Telescope lsp_document_symbols<cr>", desc = "Document Symbols" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>fc", "<cmd>Telescope commands<cr>",    desc = "Commands" },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		{
			"nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
		},
	},
}

function M.config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			prompt_prefix = "   ",
			selection_caret = " ",
			entry_prefix = "  ",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "top",
					preview_width = 0.55,
					results_width = 0.8,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
			border = true,
			borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			mappings = {
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<esc>"] = actions.close,
				},
			},
			file_ignore_patterns = {
				"%.git/",
				"node_modules/",
				"%.cache/",
				"__pycache__/",
				"%.pyc",
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
		},
	})

	telescope.load_extension("fzf")
end

return M
