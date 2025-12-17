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

		vim.lsp.enable({
			"lua_ls",
			"ts_ls",
			"html",
			"cssls",
			"tailwindcss",
			"vue_ls",
			"ruff",
			"pyright",
			"emmet_language_server",
		})

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

		-----------------------------------------------------------------------------------------------------------------------------
		--- LSP keymap configurations
		local function setup_keymaps(bufnr)
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
			end

			-- Navigation
			map("n", "gd", vim.lsp.buf.definition, "Go to definition")
			map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
			map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
			map("n", "gr", vim.lsp.buf.references, "Go to references")
			map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")

			-- Information
			-- map("n", "K", vim.lsp.buf.hover, "Hover documentation")
			map("n", "K", function()
				vim.lsp.buf.hover({
					border = "rounded", -- Sets a single line border for hover
					max_height = 25, -- Sets a maximum height
					max_width = 120, -- Sets a maximum width
				})
			end, "Hover documentation")

			map("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
			map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature help")

			-- Code actions
			map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code action")
			map("n", "<leader>cn", vim.lsp.buf.rename, "Rename symbol")
			-- Format keybinding handled by conform.nvim plugin
			-- map("n", "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

			-- Diagnostics
			map("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, "Previous diagnostic")
			map("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, "Next diagnostic")
			map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic")
			map("n", "<leader>cl", vim.diagnostic.setloclist, "Diagnostics to loclist")

			-- Inlay hints toggle (useful for manual control)
			if vim.lsp.inlay_hint then
				map("n", "<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
				end, "Toggle inlay hints")
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
			callback = function(args)
				local bufnr = args.buf
				local client = vim.lsp.get_client_by_id(args.data.client_id)

				if not client then
					return
				end

				-- Setup keymaps for this buffer
				setup_keymaps(bufnr)

				-- Enable completion triggered by <c-x><c-o>
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Enable inlay hints if supported (Neovim 0.10+)
				if client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
					vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				end

				-- Document highlight on cursor hold
				if client.server_capabilities.documentHighlightProvider then
					local highlight_group =
						vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = bufnr,
						group = highlight_group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = bufnr,
						group = highlight_group,
						callback = vim.lsp.buf.clear_references,
					})
				end
			end,
		})
	end,
}
