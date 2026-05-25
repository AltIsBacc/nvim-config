local M = {
	filetypes = { "luau" },
	settings = {
		["luau-lsp"] = {
			inlayHints = {
				functionReturnTypes = true,
				parameterNames = "all",
				parameterTypes = true
			},
			completion = {
				imports = {
					enabled = true
				}
			}
		}
	}
}

function M.setup()
	require("luau-lsp").setup {
		sourcemap = { enabled = false },
		types     = { roblox = true },
		server    = M.settings,
	}

	return M.settings
end

return M
