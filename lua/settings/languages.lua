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

-- Root markers applied to ALL language servers (merged with per-server ones)
M.global_root_markers = {
	".git",
}

-- Each entry is either a plain server name string, or a table:
-- {
--   name    = "server_name",   -- required
--   enabled = false,           -- set to false to skip registration entirely
-- }
M.lang_servers = {
	"emmylua_ls",
	"luau_lsp",
	"pyright",
	"clangd",
	"neocmake",
}

return M
