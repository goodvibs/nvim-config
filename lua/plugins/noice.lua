return {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
        "MunifTanjim/nui.nvim",
    },
    opts = {
        lsp = {
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
            },
        },
        presets = {
            bottom_search = false,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = false,
            lsp_doc_border = true,
        },
        cmdline = {
            enabled = true,
            view = "cmdline_popup",
            opts = {},
            format = {
                cmdline = { pattern = "^:", icon = "", lang = "vim", conceal = false },
                search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex", conceal = false },
                search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex", conceal = false },
                filter = { pattern = "^:%s*!", icon = "$", lang = "bash", conceal = false },
                lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*", }, icon = "", lang = "lua", conceal = false },
                help = { pattern = "^:%s*he?l?p?%s+", icon = "", conceal = false },
                input = { view = "cmdline_input", icon = "󰥻 ", conceal = false },
            },
        },
    },
}
