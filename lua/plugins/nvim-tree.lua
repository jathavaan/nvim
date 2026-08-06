return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
	keys = {
		{ "<leader>e", "<cmd>NvimTreeFocus<cr>", desc = "Focus file tree" },
		{ "<leader>F", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
		{ "<A-1>", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
		{ "<leader>fe", "<cmd>NvimTreeFindFile<cr>", desc = "Reveal current file in tree" },
	},
	opts = {
		view = {
			width = 35,
			side = "left",
		},
		filters = {
			dotfiles = false,
			custom = { "^.git$", "node_modules", "__pycache__", "bin", "obj" },
		},
		renderer = {
			group_empty = true,
			indent_markers = { enable = true },
		},
		update_focused_file = {
			enable = true,
		},
		actions = {
			open_file = { quit_on_open = false },
		},
		git = { enable = true },
		diagnostics = { enable = true },
	},
}
