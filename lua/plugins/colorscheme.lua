return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			styles = {
				comments = { italic = true },
				keywords = { italic = false },
			},
		},
		config = function(_, opts)
			-- require("tokyonight").setup(opts)
			-- vim.cmd.colorscheme("tokyonight-moon")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,

		config = function(_, opts)
			require("tokyonight").load(opts)
		end,
	},
}

