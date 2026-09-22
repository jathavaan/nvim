return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			dockerfile = { "hadolint" },
		}

		vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("UserLint", { clear = true }),
			callback = function(ev)
				-- Linters based on filetype
				lint.try_lint()

				-- actionlint only for GitHub Actions workflows, not all YAML
				local path = vim.api.nvim_buf_get_name(ev.buf)
				if path:match("[/\\]%.github[/\\]workflows[/\\]") then
					lint.try_lint("actionlint")
				end
			end,
		})
	end,
}
