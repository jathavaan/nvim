return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "VeryLazy",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()
		local set = vim.keymap.set

		-- Match-based cursors (the IdeaVim bindings)
		set({ "n", "x" }, "<C-n>", function()
			mc.matchAddCursor(1)
		end, { desc = "Add cursor at next match" })

		set({ "n", "x" }, "<C-x>", function()
			mc.matchSkipCursor(1)
		end, { desc = "Skip match, go to next" })

		set({ "n", "x" }, "g<C-n>", function()
			mc.matchAddCursor(-1)
		end, { desc = "Add cursor at previous match" })

		set({ "n", "x" }, "<C-p>", function()
			mc.deleteCursor()
		end, { desc = "Remove current cursor" })

		-- Column cursors above/below (no IdeaVim equivalent, but free)
		set({ "n", "x" }, "<A-S-Up>", function()
			mc.lineAddCursor(-1)
		end, { desc = "Add cursor above" })

		set({ "n", "x" }, "<A-S-Down>", function()
			mc.lineAddCursor(1)
		end, { desc = "Add cursor below" })

		-- Cursor at every match in the buffer / selection
		set({ "n", "x" }, "<leader>A", mc.matchAllAddCursors, { desc = "Add cursor to all matches" })

		-- Keymaps active only while multiple cursors exist
		mc.addKeymapLayer(function(layerSet)
			layerSet({ "n", "x" }, "<left>", mc.prevCursor)
			layerSet({ "n", "x" }, "<right>", mc.nextCursor)
			layerSet("n", "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		-- Catppuccin-ish highlights to match highlightedyank
		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { link = "Cursor" })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
