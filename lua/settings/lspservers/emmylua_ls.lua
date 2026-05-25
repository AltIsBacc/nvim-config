return {
    settings = {
    	["Lua"] = {
			runtime = {
				version = "LuaJIT",
				requirePattern = {
					"lua/?.lua",
					"lua/?/init.lua",
					"?/lua/?.lua",
					"?/lua/?/init.lua",
				},
			},
        	workspace = {
        		library = {
        			vim.env.VIMRUNTIME,
        			vim.fn.stdpath("config") .. "/lua",
        		},
        		checkThirdParty = false,
        	},
        	telemetry = {
        		enable = false
        	},
        },
    },
}

