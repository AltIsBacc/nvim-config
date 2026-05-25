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
	print("luaulsp srtup!")
	require("luau-lsp").setup {
		sourcemap = { enabled = false },
		types = { roblox = true },
		server = M.settings,
	}
end

return M
