local M = {}

-- Server settings passed to luau-lsp.nvim's `server` option
M.settings = {
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

-- Custom setup: called instead of vim.lsp.config() for this server.
-- Receives the resolved server settings table (M.settings) as `opts`.
function M.setup(opts)
	require("luau-lsp").setup {
		sourcemap = { enabled = false },
		types = { roblox = true },
		server = opts,
	}
end

return M
