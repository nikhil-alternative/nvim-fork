return {
	-- Autotags
	{
		"windwp/nvim-ts-autotag",
		opts = {},
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
	-- useful when there are embedded languages in certain types of files (e.g. Vue or React)
	{ "joosepalviste/nvim-ts-context-commentstring", lazy = true },
}
