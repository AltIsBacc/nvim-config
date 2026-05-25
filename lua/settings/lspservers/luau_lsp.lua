local M = {
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
	-- Return opts so lsp.lua calls vim.lsp.config("luau_lsp", opts)
	return M.settings
end

return M
