local M = {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
}

function M.config()
	require('nvim-autopairs').setup {
		check_ts = true,
		disable_filetype = { "TelescopePrompt" },
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
			offset = 0, -- Offset from pattern match
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
			check_comma = true,
			highlight = "PmenuSel",
			highlight_grey = "LineNr"
        },
	}

	-- blink.cmp handles confirm integration natively; no manual event hook needed
end

return M
