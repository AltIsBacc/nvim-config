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
	vim.lsp.config("*", {
        root_markers = { ".git" },
        capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        ),
        handlers = {
            ["textDocument/hover"] = function(err, result, ctx, config)
                return vim.lsp.handlers.hover(err, result, ctx, vim.tbl_deep_extend("force", config or {}, { border = "rounded" }))
            end,
            ["textDocument/signatureHelp"] = function(err, result, ctx, config)
                return vim.lsp.handlers.signature_help(err, result, ctx, vim.tbl_deep_extend("force", config or {}, { border = "rounded" }))
            end,
        }
    })

    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client then
                print(client.name .. " attached!")
            end
        end,
    })

    local servers_to_enable = {}
    for _, lsp_string in pairs(require('settings.languages').lang_servers) do
        local lsp = vim.split(lsp_string, "@")[1]
        table.insert(servers_to_enable, lsp)

        local ok, settings = pcall(require, "settings.lspservers." .. lsp)
        local user_opts = ok and settings or {}

        if lsp == "luau_lsp" then
            require("luau-lsp").setup {
                sourcemap = { enabled = false },
                types = { roblox = true },
                server = user_opts
            }
        else
            vim.lsp.config(lsp, user_opts)
        end
    end

   vim.lsp.enable(servers_to_enable)

    vim.diagnostic.config {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "",
                [vim.diagnostic.severity.WARN]  = "",
                [vim.diagnostic.severity.HINT]  = "",
                [vim.diagnostic.severity.INFO]  = "",
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

