return {
  "gbprod/yanky.nvim",
  opts = { },
  dependencies = { "folke/snacks.nvim" },
  keys = {
    {
      "<leader>yh",
      function()
          Snacks.picker.yanky()
      end,
      mode = { "n", "x" },
      desc = "Open Yank History",
    },
    {
        "<leader>yp",
        "<Plug>(YankyPreviousEntry)",
        desc = "Cycle previous yank",
    },
    {
        "<leader>yn",
        "<Plug>(YankyNextEntry)",
        desc = "Cycle next yank",
    }
  }
}
