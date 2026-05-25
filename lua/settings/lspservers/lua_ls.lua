return {
    settings = {
        ["Lua"] = {
            format = {
                enable = false,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
        			vim.env.VIMRUNTIME,
        			vim.fn.stdpath("config") .. "/lua"
        		},
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
