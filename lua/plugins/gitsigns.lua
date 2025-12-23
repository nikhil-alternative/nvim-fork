return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
      {
        "[c",
        function()
          require("gitsigns").prev_hunk({ navigation_message = false })
        end,
        desc = "Prev Hunk",
      },
      {
        "]c",
        function()
          require("gitsigns").next_hunk({ navigation_message = false })
        end,
        desc = "Next Hunk",
      },
  }
}
