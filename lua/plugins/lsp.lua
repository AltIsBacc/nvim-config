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

    local settings  = require("settings.languages")
    local global_rm = settings.global_root_markers or {}

    local servers_to_enable = {}
    for _, entry in pairs(settings.lang_servers) do
        -- entry is either a plain string or { name=, enabled=false }
        local name
        local entry_enabled = true
        if type(entry) == "table" then
            name          = entry.name
            entry_enabled = entry.enabled ~= false
        else
            name = entry
        end

        if not entry_enabled then goto continue end

        local lsp = vim.split(name, "@")[1]
        local ok, server = pcall(require, "settings.lspservers." .. lsp)
        local opts = (ok and type(server) == "table") and server or {}

        -- Per-server enabled = false also skips registration
        if ok and type(server) == "table" and server.enabled == false then
            goto continue
        end

        if ok and type(server) == "table" and type(server.setup) == "function" then
            server.setup()
        else
            -- Merge global root_markers with any per-server root_markers
            local server_rm = (type(opts.root_markers) == "table") and opts.root_markers or {}
            local merged_rm = vim.deepcopy(global_rm)
            for _, m in ipairs(server_rm) do
                table.insert(merged_rm, m)
            end

            local final_opts = vim.tbl_deep_extend("force", opts, {
                root_markers = merged_rm,
            })
            vim.lsp.config(lsp, final_opts)
            table.insert(servers_to_enable, lsp)
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
