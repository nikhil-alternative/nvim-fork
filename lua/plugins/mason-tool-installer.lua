return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
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
			"emmet-language-server",
		},
	},
	config = function(_, opts)
		require("mason-tool-installer").setup(opts)
	end,
}
