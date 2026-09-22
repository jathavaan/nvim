return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = {
			window = {
				winblend = 0, -- solid background, so it's readable with any colorscheme
				border = "rounded",
			},
		},
	},
}
