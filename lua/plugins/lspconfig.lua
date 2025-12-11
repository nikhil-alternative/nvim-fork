return {
  "neovim/nvim-lspconfig",
  config = function()
    vim.lsp.enable({ "lua_ls", "ts_ls", "html", "cssls", "tailwindcss", "vue_ls", "ruff", "pyright" })

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

  end
}
