return {
	"MagicDuck/grug-far.nvim",
	keys = {
		{
			"<leader>sr",
			function()
				-- Launch with the current word under the cursor as the search string
				-- :lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
				-- Launch, limiting search/replace to current file
				-- :lua require('grug-far').open({ prefills = { paths = vim.fn.expand("%") } })
				require("grug-far").open({
					prefills = { search = vim.fn.expand("<cword>"), paths = vim.fn.expand("%") },
				})
			end,
			mode = "n",
			desc = "Grug Far: s/r current word but limiting to current file",
		},
	},
}
