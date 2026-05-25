local M = {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = "BufReadPre",
    dependencies = {
        { "saghen/blink.cmp" },
		{ "lopi-py/luau-lsp.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "williamboman/mason-lspconfig.nvim" },
    },
}

function M.config()
    -- Merge blink.cmp capabilities into default LSP capabilities
    local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("blink.cmp").get_lsp_capabilities()
    )

    local settings = require("settings.languages")

    vim.lsp.config("*", {
        root_markers = settings.global_root_markers or { ".git" },
        capabilities = capabilities,
    })

    -- Rounded borders for hover and signature help (vim.lsp.with is deprecated)
    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
        config = vim.tbl_deep_extend("force", config or {}, { border = "rounded", focusable = false })
        vim.lsp.handlers.hover(err, result, ctx, config)
    end
    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
        config = vim.tbl_deep_extend("force", config or {}, { border = "rounded" })
        vim.lsp.handlers.signature_help(err, result, ctx, config)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then return end

            if client:supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
        end,
    })

    local servers_to_enable = {}
    for _, server in ipairs(settings.lang_servers) do
        local ok, config = pcall(require, "settings.lspservers." .. server.name)
        if not ok or type(config) ~= "table" then
        	-- vim.notify("Failed to load config for '" .. server.name .. "'")

            vim.lsp.config(server.name, {})
            table.insert(servers_to_enable, server.name)

            goto continue
        end

        if type(config.setup) == "function" then
            local result = config.setup()
            if type(result) == "table" then
                vim.lsp.config(server.name, result)
            end
        else
            vim.lsp.config(server.name, config)
        end

        if server.autostart then
            table.insert(servers_to_enable, server.name)
        end

        ::continue::
    end

    vim.lsp.enable(servers_to_enable)

    vim.diagnostic.config {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN]  = "",
                [vim.diagnostic.severity.HINT]  = "",
                [vim.diagnostic.severity.INFO]  = "",
            },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
            focusable = false,
            style = "minimal",
            border = "rounded",
            source = "always",
            header = "",
            prefix = "",
        }
    }
end

return M
