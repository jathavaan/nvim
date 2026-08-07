local km = vim.keymap

-- MODE NAVIGATION
km.set("i", "jj", "<ESC>", { desc = "Enter normal mode" })

-- LINE MOVEMENT AND MODIFICATION
-- Normal mode
km.set("n", "0", "^")

-- Insert mode
km.set("i", "<Tab>", "<Tab>")
km.set("i", "<S-Tab>", "<C-d>")

-- SCROLLING
km.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center buffer" })
km.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center buffer" })

-- =========================================================================
--  PANE NAVIGATION  <A-hjkl>
-- =========================================================================
km.set("n", "<A-h>", "<C-w>h", { desc = "Go to left pane" })
km.set("n", "<A-j>", "<C-w>j", { desc = "Go to lower pane" })
km.set("n", "<A-k>", "<C-w>k", { desc = "Go to upper pane" })
km.set("n", "<A-l>", "<C-w>l", { desc = "Go to right pane" })

-- Same from a terminal buffer
km.set("t", "<A-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left pane" })
km.set("t", "<A-j>", "<C-\\><C-n><C-w>j", { desc = "Go to lower pane" })
km.set("t", "<A-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper pane" })
km.set("t", "<A-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right pane" })

-- =========================================================================
--  PANE RESIZING  <S-A-hjkl>
--  Direction is relative to the divider, not the active pane.
-- =========================================================================
local function resize(dir)
	local step = 5
	if dir == "h" or dir == "l" then
		local rightmost = vim.fn.winnr("l") == vim.fn.winnr()
		local grow = (dir == "h") == rightmost
		vim.cmd(("vertical resize %s%d"):format(grow and "+" or "-", step))
	else
		local bottom = vim.fn.winnr("j") == vim.fn.winnr()
		local grow = (dir == "k") == bottom
		vim.cmd(("resize %s%d"):format(grow and "+" or "-", step))
	end
end

km.set("n", "<S-A-h>", function()
	resize("h")
end, { desc = "Resize window left" })
km.set("n", "<S-A-j>", function()
	resize("j")
end, { desc = "Resize window down" })
km.set("n", "<S-A-k>", function()
	resize("k")
end, { desc = "Resize window up" })
km.set("n", "<S-A-l>", function()
	resize("l")
end, { desc = "Resize window right" })

-- =========================================================================
--  WINDOW MANAGEMENT  <leader>w*
-- =========================================================================
km.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
km.set("n", "<leader>wh", "<C-w>s", { desc = "Split horizontally" })
km.set("n", "<leader>wq", "<C-w>c", { desc = "Close split" })
km.set("n", "<leader>wo", "<C-w>o", { desc = "Close all other splits" })
km.set("n", "<leader>we", "<C-w>=", { desc = "Equalize splits" })
km.set("n", "<leader>wx", "<C-w>x", { desc = "Swap with next split" })

-- Change orientation of the current split pair
km.set("n", "<leader>wc", "<C-w>t<C-w>H", { desc = "Make splits vertical" })
km.set("n", "<leader>wC", "<C-w>t<C-w>K", { desc = "Make splits horizontal" })

-- Maximize current split, toggling back to the saved layout
local maximized = false
km.set("n", "<leader>wm", function()
	if maximized then
		vim.cmd("wincmd =")
		maximized = false
	else
		vim.cmd("wincmd _")
		vim.cmd("wincmd |")
		maximized = true
	end
end, { desc = "Maximize split (toggle)" })

-- =========================================================================
--  BUFFER NAVIGATION  <Tab> / <S-Tab>
--  NOTE: <Tab> and <C-i> are the same keycode, so jumplist-forward moves
--  to <leader>gn to match the .ideavimrc.
-- =========================================================================
km.set("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })
km.set("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
km.set("n", "<leader>gn", "<C-i>", { desc = "Jumplist forward" })

km.set("n", "<leader>q", "<cmd>bdelete<CR>", { desc = "Close buffer" })
km.set("n", "<leader>Q", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "Close all other buffers" })

-- FILES AND FILE TREE
km.set("n", "<Space><Space>", ":w<CR>", { desc = "Save on <Space><Space>" })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- TOOLS AND UTILS
km.set("n", "<Leader>?", ":WhichKey<CR>", { desc = "Show WhichKey panel" })
