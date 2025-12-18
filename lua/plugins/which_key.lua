return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- Window options
        win = {
            border = "rounded",
            position = "bottom",
            margin = { 1, 0, 1, 0 },
            padding = { 1, 2, 1, 2 },
        },
        -- Layout options
        layout = {
            height = { min = 4, max = 25 },
            width = { min = 20, max = 50 },
            spacing = 3,
            align = "left",
        },
        -- New spec format: registrations
        registrations = {
            -- Find/Search
            { "<leader>f", group = "Find" },
            
            -- LSP
            { "<leader>l", group = "LSP" },
            
            -- Format
            { "<leader>m", group = "Format" },
            
            -- Join/Split (Treesj)
            { "<leader>j", group = "Join/Split" },
            
            -- Options/Toggles
            { "<leader>o", group = "Options" },
            
            -- Trouble
            { "<leader>x", group = "Trouble" },
            
            -- Extra/Fun
            { "<leader>z", group = "Extra" },
            { "<leader>zt", group = "Typr" },
        },
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps",
        },
    },
}
