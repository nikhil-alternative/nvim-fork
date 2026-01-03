return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	enabled = true,
	opts = {
		suggestion = {
			enabled = true,
			auto_trigger = true,
		},
	},
	config = function(_, opts)
		require("copilot").setup(opts)
	end,
}
