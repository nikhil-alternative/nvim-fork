return {
	-- Autotags
	{
		"windwp/nvim-ts-autotag",
		ft = { "html", "vue", "javascriptreact", "typescriptreact" },
		dependencies = { "nvim-treesitter/nvim-treesitter" }, -- explicitly depend on Treesitter and load on filetypes
		opts = {},
	},

	-- auto pairs brackets
	{
		"windwp/nvim-autopairs",
		ft = { "javascript", "typescirpt", "javascriptreact", "typescriptreact", "vue" },
		event = "InsertEnter",
		config = true,
	},

	-- comments
	{
		"numToStr/Comment.nvim",
		opts = {},
		event = "VeryLazy", -- loads after startup but before first usage
		keys = { "gc", "gb" }, -- load only on first use
	},
	-- useful when there are embedded languages in certain types of files (e.g. Vue or React)
	{
		"joosepalviste/nvim-ts-context-commentstring",
		ft = { "vue", "javascriptreact", "typescriptreact", "html" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "VeryLazy", -- tie to Comment.nvim
	},
}
