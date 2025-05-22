return {
    "nvim-telescope/telescope.nvim",
    lazy = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        { "echasnovski/mini.icons", version = false },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local trouble = require("trouble")
        local trouble_telescope = require("trouble.sources.telescope")

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
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case", -- "smart_case" | "ignore_case" | "respect_case"
                },
            },
        })

        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Search files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Fuzzy search project" })
        vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "View open buffers" })
        vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Search help tags" })
        -- vim.keymap.set("n", "<leader>fo", builtin.old_files, { desc = "Telescope old files" })
        vim.keymap.set("n", "<leader>fs", builtin.search_history, { desc = "View search history" })
        vim.keymap.set("n", "<leader>fc", builtin.command_history, { desc = "View command history" })
        vim.keymap.set("n", "<leader>fq", builtin.quickfix, { desc = "View quickfix list" })

        vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Reference(s)" })
        vim.keymap.set("n", "gs", builtin.lsp_document_symbols, { desc = "View document symbols" })
        vim.keymap.set("n", "gi", builtin.lsp_implementations, { desc = "Implementation(s)" })
        vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Definition(s)" })
        vim.keymap.set("n", "gt", builtin.lsp_type_definitions, { desc = "Type definition(s)" })

        -- Load the fzf extension
        telescope.load_extension("fzf")
    end,
}
