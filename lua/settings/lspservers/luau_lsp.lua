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

function M.setup(opts)
	require("luau-lsp").setup {
		sourcemap = { enabled = false },
		types = { roblox = true },
		server = opts,
	}
end

return M
