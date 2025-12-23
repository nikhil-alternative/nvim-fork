return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	opts = {
		ensure_installed = {
			"stylua",
			"lua-language-server",
			"typescript-language-server",
			"html-lsp",
			"css-lsp",
			"tailwindcss-language-server",
			"vue-language-server",
			"ruff",
			"pyright",
			"rustfmt",
			"emmet-language-server",
			"prettierd",
			"black",
			"isort",
		},
	},
	config = function(_, opts)
		require("mason-tool-installer").setup(opts)
	end,
}
