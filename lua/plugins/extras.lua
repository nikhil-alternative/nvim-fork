return {
	-- Autotags
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "vue", "javascriptreact", "typescriptreact" },
		opts = {},
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		opts = {},
		event = "VeryLazy",  -- loads after startup but before first usage
		keys = { "gc", "gb" },  -- load only on first use
	},
	-- useful when there are embedded languages in certain types of files (e.g. Vue or React)
	{ 
		"joosepalviste/nvim-ts-context-commentstring", 
		lazy = true,
		event = "VeryLazy",  -- tie to Comment.nvim
	},
}
