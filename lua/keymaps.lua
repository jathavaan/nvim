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

-- PANE NAVIGATION AND MOVEMENT
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

vim.keymap.set("n", "<A-h>", function()
	resize("h")
end, { desc = "Resize window left" })
vim.keymap.set("n", "<A-j>", function()
	resize("j")
end, { desc = "Resize window down" })
vim.keymap.set("n", "<A-k>", function()
	resize("k")
end, { desc = "Resize window up" })
vim.keymap.set("n", "<A-l>", function()
	resize("l")
end, { desc = "Resize window right" })

-- FILES AND FILE TREE
km.set("n", "<Space><Space>", ":w<CR>", { desc = "Save on <Space><Space>" })

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- TOOLS AND UTILS
km.set("n", "<Leader>?", ":WhichKey<CR>", { desc = "Show WhichKey panel" })
