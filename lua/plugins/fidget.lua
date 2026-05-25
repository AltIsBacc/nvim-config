-- LSP progress & notification UI
-- Shows LSP server status (indexing, loading, etc.) in the corner
local M = {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {
        progress = {
            poll_rate = 0,
            suppress_on_insert = false,
            ignore_done_already = false,
            ignore_empty_message = false,
            display = {
                render_limit = 16,
                done_ttl = 3,
                done_icon = "✓",
                progress_icon = { pattern = "dots", period = 1 },
                overrides = {
                    rust_analyzer = { name = "rust-analyzer" },
                },
            },
        },
        notification = {
            poll_rate = 10,
            filter = vim.log.levels.INFO,
            override_vim_notify = true,
            window = {
                normal_hl = "Comment",
                winblend = 0,
                border = "none",
                zindex = 45,
                max_width = 0,
                max_height = 0,
                x_padding = 1,
                y_padding = 0,
                align = "bottom",
                relative = "editor",
            },
        },
    },
}

return M
