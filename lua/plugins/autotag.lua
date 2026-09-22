return {
	"windwp/nvim-ts-autotag",
	event = { "BufReadPre", "BufNewFile" },
	opts = {
		opts = {
			enable_close = true, -- typing <div> inserts </div>
			enable_rename = true, -- renaming the opening tag renames the closing one
			enable_close_on_slash = false, -- typing </ auto-completes the tag name
		},
	},
}
