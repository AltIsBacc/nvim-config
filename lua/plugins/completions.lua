local M = {
	"hrsh7th/nvim-cmp",
	dependencies = {
		{
			"hrsh7th/cmp-nvim-lsp"
		},
		{
			"hrsh7th/cmp-buffer"
		},
		{
			"hrsh7th/cmp-nvim-lsp-signature-help"
		},
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
	}
}

function M.config()
	local comp_icons = {
		Text = "󰉿",
		Method = "m",
		Function = "󰊕",
		Constructor = "",
		Field = "",
		Variable = "󰆧",
		Class = "󰌗",
		Interface = "",
		Module = "",
		Property = "",
		Unit = "",
		Value = "󰎠",
		Enum = "",
		Keyword = "󰌋",
		Snippet = "",
		Color = "󰏘",
		File = "󰈙",
		Reference = "",
		Folder = "󰉋",
		EnumMember = "",
		Constant = "󰇽",
		Struct = "",
		Event = "",
		Operator = "󰆕",
		TypeParameter = "󰊄",
		Codeium = "󰚩",
		Copilot = "",
	}

	local cmp = require('cmp')
	require("luasnip.loaders.from_vscode").lazy_load()

	cmp.setup {
		snippet = {
			expand = function (args)
				require('luasnip').lsp_expand(args.body)
			end
		},
		sources = {
			{ name = "nvim_lsp" },
			{ name = "buffer" },
			{ name = "nvim_lsp_signature_help" }
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = function(entry, vim_item)
				vim_item.kind = comp_icons[vim_item.kind]
				return vim_item
			end
		},
		confirm_opts = {
			select = false,
			behavior = cmp.ConfirmBehavior.Replace
		},
		experimental = {
			ghost_text = false,
		},
		mapping = cmp.mapping.preset.insert {
			["<C-k>"] = cmp.mapping.select_prev_item(),
			["<C-j>"] = cmp.mapping.select_next_item(),
			["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
			["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
			["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
			["<CR>"] = cmp.mapping.confirm { select = true },
			["<C-e>"] = cmp.mapping {
				i = cmp.mapping.abort(),
				c = cmp.mapping.close()
			}
		},
	}
end

return M
