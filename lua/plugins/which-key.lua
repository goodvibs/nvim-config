return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
    },
    keys = {
        {
            "<leader>?",
            function()
                require("which-key").show({ global = false })
            end,
            desc = "Buffer Local Keymaps (which-key)",
        },
    },
    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>f", group = "Find" },
        })
        wk.add({
            { "<leader>t", group = "Terminal" },
        })
        wk.add({
            { "<leader>y", group = "Yank" },
        })
        wk.add({
            { "<leader>z", group = "Extra" },
        })
        wk.add({
            { "<leader>l", group = "LSP" },
        })
        wk.add({
            { "<leader>m", group = "Format" },
        })
        wk.add({
            { "<leader>o", group = "Options" },
        })

        wk.add({
            { "<leader>w", group = "Workspace" },
        })
    end,
}
