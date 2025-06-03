return {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true,
            },
        },
        presets = {
            bottom_search = true,         -- use a classic bottom cmdline for search
            command_palette = true,       -- position the cmdline and popupmenu together
            long_message_to_split = true, -- long messages will be sent to a split
            inc_rename = false,           -- enables an input dialog for inc-rename.nvim
            lsp_doc_border = true,        -- add a border to hover docs and signature help
        },
        cmdline = {
            enabled = true,         -- enables the Noice cmdline UI
            view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
            opts = {},              -- global options for the cmdline. See section on views
            ---@type table<string, CmdlineFormat>
            format = {
                cmdline = { pattern = "^:", icon = "", lang = "vim", conceal = false },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", conceal = false },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", conceal = false },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash", conceal = false },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*", }, icon = "", lang = "lua", conceal = false },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "", conceal = false },
                input = { view = "cmdline_input", icon = "󰥻 ", conceal = false }, -- Used by input()
            },
        },
    },
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
}
