local global = vim.g
local o = vim.o
local api = vim.api

vim.scriptencoding = "uft-8"

-- Map leader
global.mapleader = " "
global.maplocalleader = " "

-- Editor options
o.number = true
o.relativenumber = true
o.clipboard = unnamedplus
o.syntax = "on"
o.autoindent = true
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.encoding = "utf-8"
o.fileencoding = "utf-8"
o.ruler = true
o.mouse = "a"
o.title = true
o.hidden = true
o.ttimeoutlen = 0
o.wildmenu = true
o.showcmd = true
o.showmatch = true
o.inccommand = "split"

api.nvim_set_hl(0, "HighlightedyankRegion", { bg = "#45475a" })
api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
})
