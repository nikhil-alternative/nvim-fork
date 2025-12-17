return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {},
	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
	config = function()
		local wk = require("which-key")
		wk.add({
			{ "<leader>f", group = "Telescope" }, -- group
			{ "<leader>x", group = "Trouble" },
			{ "<leader>g", group = "LSP" },
			{ "<leader>c", group = "Code operations" },
			{ "<leader>ih", desc = "Toggle inlay hints" },
		})
	end,
}
