return {
	-- enabled = false,  -- still configured but vim.lsp.enable() won't start it
	filetypes = { "python" },
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
	settings = {
		["python"] = {
			analysis = {
				typeCheckingMode = "off"
			}
		}
	}
}
