return {
    "nvim-treesitter/nvim-treesitter",
    ft = { "javascript", "typescript", "lua", "vue", "html", "python", "rust", "css" },
    event = "BufReadPost",  -- lazy-load after opening a file
    build = ":TSUpdate",
    opts = {
        ensure_installed = { "javascript", "typescript", "lua", "vue", "python", "rust", "html", "css" },
        sync_install = false,   -- avoid blocking startup
        auto_install = false,   -- install manually to save time
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        indent = { enable = false }, -- huge perf win
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}