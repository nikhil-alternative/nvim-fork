return {
  'nvim-telescope/telescope.nvim',
  tag = 'v0.2.0',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = {
    {
      '<leader>ff',
      function() require('telescope.builtin').find_files() end,
      desc = 'Telescope: Find Files'
    },
    {
      '<leader>fg',
      function() require('telescope.builtin').live_grep() end,
      desc = 'Telescope: Live Grep'
    },
    {
      '<leader>fb',
      function() require('telescope.builtin').buffers() end,
      desc = 'Telescope: Buffers'
    },
    {
      '<leader>fk',
      function() require('telescope.builtin').keymaps() end,
      desc = 'Telescope: Keymappings'
    },
  },
}
