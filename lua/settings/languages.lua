local M = {}

M.langs = {
	"lua",
	"luau",
	"python",
	"cpp",
	"cmake",
	"java",
	"html",
	"css",
	"cmake"
}

-- Root markers applied to ALL servers via vim.lsp.config("*", ...)
M.global_root_markers = {
	".git",
}

-- Each entry is either a plain server name string, or a table:
-- {
--   name    = "server_name",  -- required
--   autostart = false,          -- still configured via vim.lsp.config but NOT started
-- }
M.lang_servers = {
	"emmylua_ls",
	{ name = "luau_lsp", autostart = false },
	"pyright",
	"clangd",
	"neocmake",
}

return M
