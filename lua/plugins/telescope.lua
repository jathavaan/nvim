return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	cmd = "Telescope",
	keys = {
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		{ "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Keymaps" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Search in buffer" },
		{ "<leader>fw", "<cmd>Telescope grep_string<cr>", desc = "Grep word under cursor" },
		{ "<leader><leader>", "<cmd>Telescope resume<cr>", desc = "Resume last picker" },
	},
	opts = function()
		local actions = require("telescope.actions")
		return {
			defaults = {
				layout_strategy = "horizontal",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = { preview_width = 0.55, prompt_position = "top" },
					width = 0.9,
					height = 0.85,
				},
				path_display = { "truncate" },
				file_ignore_patterns = {
					"^%.git/",
					"node_modules/",
					"__pycache__/",
					"%.venv/",
					"bin/",
					"obj/",
				},
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<C-u>"] = false,
						["<C-d>"] = actions.preview_scrolling_down,
						["<Esc>"] = actions.close,
					},
				},
			},
			pickers = {
				find_files = { hidden = true },
				buffers = {
					sort_lastused = true,
					mappings = { i = { ["<C-x>"] = actions.delete_buffer } },
				},
			},
		}
	end,
}
