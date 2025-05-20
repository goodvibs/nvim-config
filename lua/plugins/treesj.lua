return {
    "Wansmer/treesj",
    keys = {
        { "<leader>mt", "<cmd>TSJToggle<cr>", desc = "Toggle structure pack/unpack" },
        { "<leader>mp", "<cmd>TSJJoin<cr>", desc = "Pack structure into single line" },
        { "<leader>mu", "<cmd>TSJSplit<cr>", desc = "Unpack structure over line(s)" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" }, -- if you install parsers with `nvim-treesitter`
    config = function()
        require("treesj").setup({})
    end,
}
