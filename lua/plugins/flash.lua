return {
	"folke/flash.nvim",
	event = "VeryLazy",
	opts = {
		search = {
			mode = function(str)
				return "\\c" .. vim.fn.escape(str, "\\/.*$^~[]")
			end,
			incremental = false,
		},
		modes = {
			char = {
				enabled = true,
				jump_labels = true,
				highlight = { backdrop = false },
				keys = { "f", "F", "t", "T", ";", "," },
				search = {
					mode = function(str)
						return "\\c" .. vim.fn.escape(str, "\\/.*$^~[]")
					end,
				},
			},
			search = {
				enabled = false,
			},
		},
		label = {
			uppercase = false,
			rainbow = { enabled = false },
		},
		jump = {
			autojump = false,
		},
	},
	keys = {
		{
			"s",
			mode = { "n", "x", "o" },
			function()
				require("flash").jump()
			end,
			desc = "Flash jump",
		},
		{
			"S",
			mode = { "n", "x", "o" },
			function()
				require("flash").treesitter()
			end,
			desc = "Flash treesitter",
		},
		{
			"r",
			mode = "o",
			function()
				require("flash").remote()
			end,
			desc = "Remote flash",
		},
		{
			"<C-s>",
			mode = "c",
			function()
				require("flash").toggle()
			end,
			desc = "Toggle flash search",
		},
	},
}
