return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>cf",
			function()
				require("conform").format({ async = true }, function(err, did_edit)
					if not err and did_edit then
						vim.notify("Code formatted", vim.log.levels.INFO, { title = "Conform" })
					end
				end)
			end,
			mode = { "n", "v" },
			desc = "Format buffer",
		},
	},
	opts = {
		formatters_by_ft = {
			-- The "all" key is a special filetype that applies to all buffers
			-- unless a more specific filetype entry is present.
			["*"] = { "prettier" },

			-- Conform will run the first available formatter
			-- javascript = { "prettier", "prettierd", stop_after_first = true },

			lua = { "stylua" },
			-- Conform will run multiple formatters sequentially
			python = { "isort", "black" },
		},
		default_format_opts = {
			lsp_format = "fallback",
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}

