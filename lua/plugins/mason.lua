return {
	"mason-org/mason.nvim",
	opts = {},
	config = function(_, opts)
		require("mason").setup(opts)
	end
}
