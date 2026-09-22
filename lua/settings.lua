local o = vim.o
local api = vim.api

-- Leader (must be set before lazy.nvim loads plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Editor options
o.number = true
o.relativenumber = true
o.clipboard = "unnamedplus"
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.mouse = "a"
o.title = true
o.ttimeoutlen = 0
o.showmatch = true
o.inccommand = "split"
o.termguicolors = false
o.signcolumn = "yes"

-- Add filetypes for Docker compose
vim.filetype.add({
	pattern = {
		["compose.*%.ya?ml"] = "yaml.docker-compose",
		["docker%-compose.*%.ya?ml"] = "yaml.docker-compose",
	},
})

-- Yank highlight
local function set_yank_hl()
	api.nvim_set_hl(0, "YankHighlight", { link = "Visual" })
end

set_yank_hl()

local yank_group = api.nvim_create_augroup("YankHighlight", { clear = true })

api.nvim_create_autocmd("ColorScheme", { group = yank_group, callback = set_yank_hl })

api.nvim_create_autocmd("TextYankPost", {
	group = yank_group,
	callback = function()
		vim.hl.on_yank({ higroup = "YankHighlight", timeout = 300 })
	end,
})
