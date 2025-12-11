return {
  'stevearc/conform.nvim',
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
        lua = { "stylua" },
        -- Conform will run the first available formatter
        javascript = { "prettier", "prettierd", stop_after_first = true },
        -- Conform will run multiple formatters sequentially
        python = { "isort", "black" },
      },
      default_format_opts = {
        lsp_format = "fallback",
      },
  },
  config = function(_, opts)
    require('conform').setup(opts)
  end,
}