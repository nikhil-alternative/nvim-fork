return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	config = function()
		local wk = require("which-key")

		-- Register global LSP keymaps
		wk.add({
			{ "gr", group = "LSP" }, -- group prefix
			{ "gra", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code Action" },
			{ "gri", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to Implementation" },
			{ "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename Symbol" },
			{ "grr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },
			{ "grt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", desc = "Type Definition" },
			{ "grd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Type Definition" },
			{ "grD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Type Definition" },
			{ "gO", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", desc = "Document Symbols" },
		}, { mode = { "n", "v" } })

		-- Optional: other groups
		wk.add({
			{ "<leader>f", group = "Telescope" },
			{ "<leader>x", group = "Trouble" },
			{ "<leader>g", group = "LSP" },
			{ "<leader>c", group = "Code operations" },
			{ "<leader>ih", desc = "Toggle inlay hints" },
		})
	end,
}
