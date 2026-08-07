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
o.clipboard = "unnamedplus"
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
o.termguicolors = false

local function set_yank_hl()
  api.nvim_set_hl(0, "YankHighlight", { link = "Visual" })
end

set_yank_hl()
api.nvim_create_autocmd("ColorScheme", { callback = set_yank_hl })

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local hl = vim.hl or vim.highlight
    hl.on_yank({ higroup = "YankHighlight", timeout = 300 })
  end,
})
