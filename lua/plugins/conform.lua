return {
	"stevearc/conform.nvim",
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
			-- PROBLEM: `*` will run for every filetype (even ones it shouldn’t)
			-- ["*"] = { "prettier" },

			-- Conform will run multiple formatters sequentially
			-- python = { "isort", "black" },

			-- Conform will run the first available formatter
			-- javascript = { "prettier", "prettierd", stop_after_first = true },

			javascript = { "prettier" },
			typescript = { "prettier" },
			html = { "prettier" },
			css = { "prettier" },
			javacriptreact = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			yaml = { "prettier" },
            rust = { "rustfmt" },
			python = { "isort", "black" },
			lua = { "stylua" },
		},
		default_format_opts = {
			lsp_format = "fallback",
			timeout_ms = 1000, -- Without a timeout, slow formatters can block longer than expected.
		},
	},
	config = function(_, opts)
		require("conform").setup(opts)
	end,
}