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

-- Each entry is a table with three required fields:
-- {
--   name       = "server_name",  -- mason-lspconfig server name
--   autostart  = true|false,     -- whether vim.lsp.enable() starts it automatically
--   executable = "binary-name",  -- binary checked in PATH before Mason installs
-- }
M.lang_servers = {
	{ name = "emmylua_ls", autostart = true,  executable = "emmylua_ls" },
	{ name = "luau_lsp",   autostart = false, executable = "luau-lsp"   },
	{ name = "ty",         autostart = true,  executable = "ty"         },
	{ name = "clangd",     autostart = true,  executable = "clangd"     },
	{ name = "neocmake",   autostart = true,  executable = "neocmake"   },
}

return M
