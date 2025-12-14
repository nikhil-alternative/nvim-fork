-- https://github.com/vuejs/language-tools/wiki/Neovim
return {
	"neovim/nvim-lspconfig",
	config = function()
		local vue_language_server_path = vim.fn.expand("$MASON/packages")
			.. "/vue-language-server"
			.. "/node_modules/@vue/language-server"

		local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }
		local vue_plugin = {
			name = "@vue/typescript-plugin",
			location = vue_language_server_path,
			languages = { "vue" },
			configNamespace = "typescript",
		}

		local ts_ls_config = {
			init_options = {
				plugins = {
					vue_plugin,
				},
			},
			filetypes = tsserver_filetypes,
		}

		-- If you are on most recent `nvim-lspconfig`
		local vue_ls_config = {
			cmd = { "vue-language-server", "--stdio" },
			filetypes = { "vue" },
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
		}

		vim.lsp.config("vue_ls", vue_ls_config)
		vim.lsp.config("ts_ls", ts_ls_config)

		vim.lsp.enable({ "lua_ls", "ts_ls", "html", "cssls", "tailwindcss", "vue_ls", "ruff", "pyright", "emmet_language_server" })

		-- diagnostic configuration
		vim.diagnostic.config({
			virtual_text = true,
			underline = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "E ",
					[vim.diagnostic.severity.WARN] = "W ",
					[vim.diagnostic.severity.INFO] = "I ",
					[vim.diagnostic.severity.HINT] = "H ",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "ErrorMsg",
					[vim.diagnostic.severity.WARN] = "WarningMsg",
				},
			},
		})
	end,
}
