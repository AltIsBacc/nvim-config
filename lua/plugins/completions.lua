local M = {
	"saghen/blink.cmp",
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			event = "InsertEnter",
			dependencies = {
				{
					"rafamadriz/friendly-snippets"
				}
			}
		}
	},
	event = {
		"InsertEnter",
		"CmdlineEnter"
	},
	version = "1.*",
}

function M.config()
	local comp_icons = {
		Text          = "󰉿",
		Method        = "󰆧",
		Function      = "󰊕",
		Constructor   = "󰒓",
		Field         = "󰜢",
		Variable      = "󰀫",
		Class         = "󰠱",
		Interface     = "󰕘",
		Module        = "󰏗",
		Property      = "󰖷",
		Unit          = "󰑭",
		Value         = "󰎠",
		Enum          = "󰕘",
		Keyword       = "󰌋",
		Snippet       = "󰲋",
		Color         = "󰏘",
		File          = "󰈙",
		Reference     = "󰈇",
		Folder        = "󰉋",
		EnumMember    = "󰕘",
		Constant      = "󰇽",
		Struct        = "󰙅",
		Event         = "󰉁",
		Operator      = "󰆕",
		TypeParameter = "󰊄",
		Codeium       = "󰚩",
		Copilot       = "",
	}

	require("luasnip.loaders.from_vscode").lazy_load()

	require("blink.cmp").setup {
		snippets = {
			preset = "luasnip",
		},
		sources = {
			default = { "lsp", "buffer", "snippets" },
		},
		signature = {
			enabled = true,
			window = { border = "rounded" },
		},
		completion = {
			menu = {
				border = "rounded",
				draw = {
					columns = { { "kind_icon" }, { "label", gap = 1 } },
					components = {
						kind_icon = {
							text = function(ctx)
								return comp_icons[ctx.kind] or ctx.kind_icon
							end,
						},
					},
				},
			},
			documentation = {
				auto_show = true,
				window = { border = "rounded" },
			},
			ghost_text = { enabled = false },
		},
		keymap = {
			preset = "none",
			["<C-k>"]     = { "select_prev", "fallback" },
			["<C-j>"]     = { "select_next", "fallback" },
			["<C-b>"]     = { "scroll_documentation_up", "fallback" },
			["<C-f>"]     = { "scroll_documentation_down", "fallback" },
			["<C-Space>"] = { "show", "fallback" },
			["<CR>"]      = { "accept", "fallback" },
			["<C-e>"]     = { "hide", "fallback" },
		},
	}
end

return M
