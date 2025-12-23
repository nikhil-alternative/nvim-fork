return {
	"nvim-mini/mini.statusline",
	event = "VeryLazy",  -- loads after startup to reduce initial lag
	version = "*",
	opts = {
		use_icons = vim.g.have_nerd_font or false,  -- ensure boolean
		section_location = function()
			return "%2l:%-2v"
		end,
	},
}
