return {
	"mason-org/mason.nvim",
	cmd = { "Mason", "MasonInstall" },
	opts = {},
	config = function(_, opts)
		require("mason").setup(opts)
	end
}
