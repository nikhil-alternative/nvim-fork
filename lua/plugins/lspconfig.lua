-- Neovim v0.11+ LSP: use vim.lsp.config + vim.lsp.enable (no lspconfig.setup)
-- https://github.com/vuejs/language-tools/wiki/Neovim
--[[ 
INFO:
vim.lsp.enable({ … }) is convenient: all servers ready immediately.
But it’s expensive: it loads servers that might not be needed.
Replacing it with per-server lazy setup() = faster startup, lower memory, and smoother editing.
Each .setup() only loads when a buffer of the correct filetype is opened. 
]]

return {
	"neovim/nvim-lspconfig",
	-- Load when editing code (keeps startup lighter than loading on VimEnter)
	event = { "BufReadPre", "BufNewFile" },

	config = function()
		---------------------------------------------------------------------------
		-- Diagnostics (keep this global; it's cheap and applies everywhere)
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

		---------------------------------------------------------------------------
		-- Vue + TS (Volar + @vue/typescript-plugin for ts_ls)
		local vue_language_server_path = vim.fn.expand("$MASON/packages")
			.. "/vue-language-server"
			.. "/node_modules/@vue/language-server"

		local tsserver_filetypes = {
			"typescript",
			"javascript",
			"javascriptreact",
			"typescriptreact",
			"vue",
		}

		local vue_plugin = {
			name = "@vue/typescript-plugin",
			location = vue_language_server_path,
			languages = { "vue" },
			configNamespace = "typescript",
		}

		vim.lsp.config("ts_ls", {
			filetypes = tsserver_filetypes,
			init_options = {
				plugins = { vue_plugin },
			},
		})

		vim.lsp.config("vue_ls", {
			cmd = { "vue-language-server", "--stdio" },
			filetypes = { "vue" },
			root_markers = { "package.json", "tsconfig.json", "jsconfig.json", ".git" },
		})

		---------------------------------------------------------------------------
		-- Enable servers PER FILETYPE (performance win)
		-- This avoids starting unrelated LSPs on startup.
		local enable_by_ft = {
			lua = { "lua_ls" },
			python = { "pyright" },
			rust = { "rust_analyzer" },
			html = { "html", "emmet_language_server" },
			css = { "cssls" },
			scss = { "cssls" },
			javascript = { "ts_ls" },
			typescript = { "ts_ls" },
			javascriptreact = { "ts_ls", "tailwindcss", "emmet_language_server" },
			typescriptreact = { "ts_ls", "tailwindcss", "emmet_language_server" },
			vue = { "vue_ls", "ts_ls", "tailwindcss", "emmet_language_server" },
		}

		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("UserLspEnableByFt", { clear = true }),
			callback = function(ev)
				local ft = vim.bo[ev.buf].filetype
				local servers = enable_by_ft[ft]
				if not servers then
					return
				end
				-- enabling repeatedly is fine; Neovim won't double-start attached clients
				vim.lsp.enable(servers)
			end,
		})

		---------------------------------------------------------------------------
		-- Keymaps + per-buffer attach behavior
		local function setup_keymaps(bufnr)
			local function map(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
			end

			map({ "n", "i" }, "<C-k>", vim.lsp.buf.signature_help, "Signature help")

			-- Actions
			map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
			map("n", "<leader>cn", vim.lsp.buf.rename, "Rename symbol")

			-- LSP
			map("n", "grd", vim.lsp.buf.definition, "Jump to the declaration of the symbol under the cursor.")
			map("n", "grD", vim.lsp.buf.declaration, "Jump to the definition of the symbol under the cursor.")

			-- Diagnostics
			map("n", "[d", function()
				vim.diagnostic.jump({ count = -1 })
			end, "Previous diagnostic")
			map("n", "]d", function()
				vim.diagnostic.jump({ count = 1 })
			end, "Next diagnostic")
			map("n", "<leader>cd", vim.diagnostic.open_float, "Show diagnostic")

			-- Inlay hints toggle
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

				-- disable unused default keymaps from nvim 0.11
				-- https://neovim.io/doc/user/lsp.html#_defaults
				-- for _, k in ipairs({ "gra", "gri", "grn", "grr", "grt", "gO" }) do
				-- 	pcall(vim.keymap.del, "n", k, { buffer = bufnr })
				-- end

				setup_keymaps(bufnr)
				vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

				-- Inlay hints: keep disabled by default (good perf + less noise)
				if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(false, { bufnr = bufnr })
				end

				-- Document highlight can be a small CPU cost on CursorHold; skip for huge files.
				if client.server_capabilities.documentHighlightProvider then
					local line_count = vim.api.nvim_buf_line_count(bufnr)
					if line_count <= 5000 then
						local hl_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = bufnr,
							group = hl_group,
							callback = vim.lsp.buf.document_highlight,
						})
						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = bufnr,
							group = hl_group,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end
			end,
		})
	end,
}
