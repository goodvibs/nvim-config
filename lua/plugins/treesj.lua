return {
    "Wansmer/treesj",
    keys = {
        { "<leader>jt", "<cmd>TSJToggle<cr>", desc = "Toggle structure pack/unpack" },
        { "<leader>jj", "<cmd>TSJJoin<cr>", desc = "Join structure into single line" },
        { "<leader>js", "<cmd>TSJSplit<cr>", desc = "Split structure over lines" },
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({
            -- Use default keymaps (we override with our own above)
            use_default_keymaps = false,
            -- Check syntax node before formatting
            check_syntax_node = true,
            -- Maximum line length for joining
            max_join_length = 120,
            -- Cursor behavior: 'start', 'end', 'inner_start', 'inner_end'
            cursor_behavior = "start",
            -- Notify about changes
            notify = true,
            -- Dot repeat support
            dot_repeat = true,
            -- Formatting options
            format = {
                -- Enable/disable formatting
                enabled = true,
                -- Lines around cursor to format
                lines = {
                    -- Format lines before cursor
                    before = 0,
                    -- Format lines after cursor
                    after = 0,
                },
            },
            -- Languages to enable for (empty = all)
            langs = {},
            -- Languages to disable for
            disable = {},
        })
    end,
}
