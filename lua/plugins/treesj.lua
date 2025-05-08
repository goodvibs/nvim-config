return {
  'Wansmer/treesj',
  keys = {
      "<leader>st", "<cmd>TSJToggle<cr>", desc = "Toggle structure pack/unpack",
      "<leader>sp", "<cmd>TSJJoin<cr>", desc = "Pack structure into single line",
      "<leader>su", "<cmd>TSJSplit<cr>", desc = "Unpack structure over line(s)",
  },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup({})
  end,
}
