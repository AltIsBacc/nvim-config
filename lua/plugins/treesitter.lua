local M = {
	"nvim-treesitter/nvim-treesitter",
	event = "BufReadPost",
	lazy = false,
	build = ':TSUpdate',
	dependencies = {
		{
			"nvim-tree/nvim-web-devicons"
		},
	},
}

function M.config()
	if vim.bo.filetype == "luau" then
		require('luau-lsp').treesitter()
	end

	-- nvim-treesitter v1 removed the 'configs' module; options are now set
	-- directly via vim.treesitter and plugin-level opts/setup on the main module.
	local langs = require('settings.languages').langs

	-- Ensure parsers are installed
	vim.treesitter.language.add = vim.treesitter.language.add or function() end
	require("nvim-treesitter").setup({
		ensure_installed = langs,
		sync_install = false,
	})

	-- Highlight is enabled per-buffer via the built-in vim.treesitter.start().
	-- nvim-treesitter v1 wires this up automatically when parsers are present.
	-- The 'highlight', 'indent', and 'autopairs' sub-module keys no longer exist.
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "*",
		callback = function(args)
			local ft = vim.bo[args.buf].filetype
			-- Disable highlight for css (matches previous config)
			if ft == "css" then
				vim.treesitter.stop(args.buf)
				return
			end
			local ok, _ = pcall(vim.treesitter.start, args.buf)
			if not ok then
				-- Parser not available for this filetype, skip silently
			end
		end,
	})
end

return M
