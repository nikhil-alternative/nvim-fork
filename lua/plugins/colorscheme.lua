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
			-- vim.cmd.colorscheme("tokyonight-storm")
		end,
	},
	{
		"sainnhe/gruvbox-material",
		lazy = false,
		priority = 1000,
		config = function()
			-- Light vs dark:
			vim.o.background = "light" -- important

			-- Contrast (not light/dark):
			vim.g.gruvbox_material_background = "soft" -- "soft" | "medium" | "hard"

			-- Palette:
			vim.g.gruvbox_material_palette = "material" -- "material" | "mix" | "original"

			vim.cmd.colorscheme("gruvbox-material")
		end,
	},
}
