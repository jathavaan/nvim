return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	opts = {
		focus = true,
		warn_no_results = false,
		open_no_results = true,
		win = { size = 0.3 },
	},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
		{ "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
		{ "<leader>xs", "<cmd>Trouble symbols toggle<cr>", desc = "Symbols outline" },
		{ "<leader>xr", "<cmd>Trouble lsp_references toggle<cr>", desc = "References" },
		{ "<leader>xd", "<cmd>Trouble lsp_definitions toggle<cr>", desc = "Definitions" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<cr>", desc = "Location list" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix list" },
	},
}
