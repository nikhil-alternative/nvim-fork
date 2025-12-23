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
    ft = { "javascript", "typescript", "vue", "lua", "html", "css" },
    config = function()
        local lspconfig = require("lspconfig")

        -- Typescript / Vue
        local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

        lspconfig.tsserver.setup({
            filetypes = tsserver_filetypes,
            init_options = {
                plugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vim.fn.expand("$MASON/packages") .. "/vue-language-server/node_modules/@vue/language-server",
                        languages = { "vue" },
                        configNamespace = "typescript",
                    },
                },
            },
        })

        lspconfig.vue_ls.setup({
            cmd = { "vue-language-server", "--stdio" },
            filetypes = { "vue" },
            root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git"),
        })

        -- Other servers: lazy-load on buffer open
        local servers = { "lua_ls", "html", "cssls", "tailwindcss", "ruff", "pyright", "emmet_language_server" }
        for _, server in ipairs(servers) do
            lspconfig[server].setup({})
        end

        -- Diagnostics
        vim.diagnostic.config({
            virtual_text = true,
            underline = true,
            signs = {
                text = { [vim.diagnostic.severity.ERROR] = "E ", [vim.diagnostic.severity.WARN] = "W ", [vim.diagnostic.severity.INFO] = "I ", [vim.diagnostic.severity.HINT] = "H " },
                numhl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg", [vim.diagnostic.severity.WARN] = "WarningMsg" },
            },
        })

        -- Buffer-local keymaps
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true }),
            callback = function(args)
                local bufnr = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                local function map(mode, lhs, rhs, desc)
                    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = "LSP: " .. desc, silent = true })
                end

                map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                if vim.lsp.inlay_hint and client.server_capabilities.inlayHintProvider then
                    map("n", "<leader>ih", function()
                        vim.lsp.inlay_hint.toggle(bufnr)
                    end, "Toggle inlay hints")
                end

                -- Document highlight only for small files
                if client.server_capabilities.documentHighlightProvider and vim.api.nvim_buf_line_count(bufnr) < 5000 then
                    local group = vim.api.nvim_create_augroup("LspHighlight_" .. bufnr, { clear = true })
                    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { buffer = bufnr, group = group, callback = vim.lsp.buf.document_highlight })
                    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { buffer = bufnr, group = group, callback = vim.lsp.buf.clear_references })
                end
            end,
        })
    end,
}
