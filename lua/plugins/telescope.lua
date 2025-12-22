return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "echasnovski/mini.icons",                   version = false },
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        local telescope = require("telescope")

        telescope.setup({
            defaults = {
                layout_config = {
                    horizontal = {
                        width = { padding = 0 },
                        height = { padding = 0 },
                        preview_width = 0.5,
                    },
                },
            },
            pickers = {
                find_files = {
                    hidden = true,
                },
                live_grep = {
                    additional_args = { "--hidden" },
                },
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
                },
            },
        })


        telescope.load_extension("fzf")

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>fb", builtin.current_buffer_fuzzy_find, { desc = "Fuzzy search in current buffer" })
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search files" })
        vim.keymap.set("n", "<leader>fs", builtin.live_grep, { desc = "Fuzzy search" })
        vim.keymap.set("n", "<leader>fgf", builtin.git_files, { desc = "Search git files" })
        vim.keymap.set("n", "<leader>fgb", builtin.git_branches, { desc = "Search git branches" })
        vim.keymap.set("n", "<leader>fo", builtin.buffers, { desc = "Search open buffers" })
        vim.keymap.set("n", "<leader>f?", builtin.help_tags, { desc = "Search help tags" })
        vim.keymap.set("n", "<leader>fz", builtin.oldfiles, { desc = "Search old files" })
        vim.keymap.set("n", "<leader>f/", builtin.search_history, { desc = "Search search history" })
        vim.keymap.set("n", "<leader>fcc", builtin.commands, { desc = "Search available commands" })
        vim.keymap.set("n", "<leader>fch", builtin.command_history, { desc = "Search command history" })
        vim.keymap.set("n", "<leader>ft", builtin.treesitter, { desc = "Search treesitter AST" })
        vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "Search quickfix list" })
        vim.keymap.set("n", "<leader>fj", builtin.jumplist, { desc = "Search jumplist" })
        vim.keymap.set("n", "<leader>fl", builtin.loclist, { desc = "Search location list" })
        vim.keymap.set("n", "<leader>fv", builtin.vim_options, { desc = "Search vim options" })
        vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume the previous search" })
    end,
}
