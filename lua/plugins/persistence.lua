return {
  "folke/persistence.nvim",
  event = "BufReadPre", -- only save session after opening a real file
  opts = {
    -- where session files are stored
    dir = vim.fn.stdpath("state") .. "/sessions/",
    -- what to persist
    options = { "buffers" },
  },
  keys = {
    {
      "<leader>qs",
      function() require("persistence").load() end,
      desc = "Persistence: Load Session",
    }
  },
}
