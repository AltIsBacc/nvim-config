return {
    settings = {
        Lua = {
            format = {
                enable = false,
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                -- Modern array-style library (lua_ls 3.x+)
                library = vim.list_extend(
                    vim.api.nvim_get_runtime_file("lua", true),
                    { vim.fn.stdpath("config") .. "/lua" }
                ),
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
