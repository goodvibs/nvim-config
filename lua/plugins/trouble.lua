return {
    "folke/trouble.nvim",
    opts = {},
    cmd = "Trouble",
    keys = {
        { "<leader>xw", "<cmd>Trouble diagnostics toggle<CR>",              desc = "Trouble workspace diagnostics" },
        { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<CR>", desc = "Trouble buffer diagnostics" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<CR>",                   desc = "Trouble quickfix list" },
        { "<leader>xl", "<cmd>Trouble loclist toggle<CR>",                  desc = "Trouble location list" },
    },
}
