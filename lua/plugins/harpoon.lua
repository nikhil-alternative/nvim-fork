return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    {
      "<leader>a",
      function() require("harpoon"):list():add() end,
      desc = "Harpoon: Add file",
    },
    {
      "<C-e>",
      function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end,
      desc = "Harpoon: Toggle quick menu",
    },
    {
      "<leader>1",
      function() require("harpoon"):list():select(1) end,
      desc = "Harpoon: Select file 1",
    },
    {
      "<leader>2",
      function() require("harpoon"):list():select(2) end,
      desc = "Harpoon: Select file 2",
    },
    {
      "<leader>3",
      function() require("harpoon"):list():select(3) end,
      desc = "Harpoon: Select file 3",
    },
    {
      "<leader>4",
      function() require("harpoon"):list():select(4) end,
      desc = "Harpoon: Select file 4",
    },
  },
}