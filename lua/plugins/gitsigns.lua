return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		current_line_blame = false, -- toggle with <leader>gB
		current_line_blame_opts = { delay = 300 },
		preview_config = { border = "rounded" },
		on_attach = function(bufnr)
			local gs = require("gitsigns")

			local function map(mode, keys, fn, desc)
				vim.keymap.set(mode, keys, fn, { buffer = bufnr, desc = desc })
			end

			-- Navigation
			map("n", "]h", function()
				gs.nav_hunk("next")
			end, "Next hunk")
			map("n", "[h", function()
				gs.nav_hunk("prev")
			end, "Prev hunk")

			-- Hunk actions
			map("n", "<leader>gs", gs.stage_hunk, "Stage/unstage hunk")
			map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
			map("v", "<leader>gs", function()
				gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Stage selected lines")
			map("v", "<leader>gr", function()
				gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
			end, "Reset selected lines")
			map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")

			-- Buffer actions
			map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
			map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")

			-- Blame
			map("n", "<leader>gb", function()
				gs.blame_line({ full = true })
			end, "Blame line")
			map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle inline blame")

			-- Diff
			map("n", "<leader>gd", gs.diffthis, "Diff against index")
		end,
	},
}
