local M = {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = "BufReadPre",
    dependencies = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "lopi-py/luau-lsp.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        { "williamboman/mason-lspconfig.nvim" },
    },
}

function M.config()
    -- Merge cmp capabilities into default LSP capabilities
    local capabilities = vim.tbl_deep_extend(
        "force",
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    )

    vim.lsp.config("*", {
        root_markers = { ".git" },
        capabilities = capabilities,
    })

    -- Rounded borders for hover and signature help
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
        vim.lsp.handlers.hover,
        { border = "rounded", focusable = false }
    )
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        { border = "rounded" }
    )

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if not client then return end

            if client.supports_method("textDocument/inlayHint") then
                vim.lsp.inlay_hint.enable(true, { bufnr = args.buf })
            end
        end,
    })

    local servers_to_enable = {}
    for _, lsp_string in pairs(require("settings.languages").lang_servers) do
        local lsp = vim.split(lsp_string, "@")[1]
        table.insert(servers_to_enable, lsp)

        local ok, server = pcall(require, "settings.lspservers." .. lsp)
        local opts = ok and server or {}

        if ok and type(server.setup) == "function" then
            -- Server defines its own setup (e.g. luau_lsp uses a wrapper plugin)
            server.setup(server.settings or {})
        else
            vim.lsp.config(lsp, opts)
        end
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
