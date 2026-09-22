local parsers = {
	-- Web
	"javascript",
	"typescript",
	"tsx",
	"jsdoc",
	"html",
	"css",
	"scss",
	"json",
	-- Infra
	"dockerfile",
	"bicep",
	"yaml",
	"toml",
	"sql",
	"bash",
	-- Other
	"python",
	"lua",
	"luadoc",
	"markdown",
	"markdown_inline",
	"regex",
	"vim",
	"vimdoc",
	"query",
	-- Git
	"diff",
	"gitcommit",
	"git_config",
	"gitignore",
}

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false, -- nvim-treesitter doesn't support lazy-loading
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install(parsers)

		-- Compose files have their own filetype, but should use the yaml parser
		vim.treesitter.language.register("yaml", "yaml.docker-compose")

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("TreesitterStart", { clear = true }),
			callback = function(ev)
				-- Start highlighting if a parser exists for this filetype
				if not pcall(vim.treesitter.start, ev.buf) then
					return
				end
				vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
