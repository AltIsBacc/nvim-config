return {
	-- enabled = false,  -- uncomment to disable this server entirely
	root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt" },
	settings = {
		["python"] = {
			analysis = {
				typeCheckingMode = "off"
			}
		}
	}
}
