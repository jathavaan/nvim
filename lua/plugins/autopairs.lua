return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	opts = {
		check_ts = true,
		disable_filetype = { "TelescopePrompt" },
		fast_wrap = {
			map = "<M-e>",
			chars = { "{", "[", "(", '"', "'" },
			end_key = "$",
			keys = "qwertyuiopzxcvbnmasdfghjkl",
		},
	},
}
