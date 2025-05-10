return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "echasnovski/mini.icons", version = false },
    },
    config = function()
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

        local telescope = require("telescope")
        telescope.setup({
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
                },
            },
        })

        -- Load the fzf extension
        telescope.load_extension("fzf")
    end,
}
