local M = {
	"stevearc/oil.nvim",
	keys = {
		{ "<leader>e", "<cmd>Oil<cr>", desc = "File Explorer (Oil)" },
	},
	cmd = "Oil",
}

function M.config()
	require("oil").setup {
		default_file_explorer = true,
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		view_options = {
			show_hidden = true,
		},
		float = {
			border = "rounded",
		},
		keymaps = {
			["g?"]    = { "actions.show_help",        mode = "n" },
			["<CR>"]  = "actions.select",
			["<C-v>"] = { "actions.select",           opts = { vertical   = true } },
			["<C-s>"] = { "actions.select",           opts = { horizontal = true } },
			["-"]     = { "actions.parent",           mode = "n" },
			["_"]     = { "actions.open_cwd",         mode = "n" },
			["gs"]    = { "actions.change_sort",      mode = "n" },
			["gx"]    = "actions.open_external",
			["g."]    = { "actions.toggle_hidden",    mode = "n" },
			["<C-r>"] = "actions.refresh",
			["q"]     = { "actions.close",            mode = "n" },
		},
		use_default_keymaps = false,
	}
end

return M
