return {
    "folke/which-key.nvim",
    event = "VeryLazy",  -- loads after startup
    opts = {},
    config = function()
        local wk = require("which-key")

        -- Add groups
        wk.add({
            { "<leader>f", group = "Telescope" },
            { "<leader>x", group = "Trouble" },
            { "<leader>g", group = "LSP" },
            { "<leader>c", group = "Code operations" },
            { "<leader>ih", desc = "Toggle inlay hints" },
        })

        vim.keymap.set("n", "<leader>?", function()
            wk.show({ global = false })
        end, { desc = "Buffer Local Keymaps", silent = true })
    end,
}
