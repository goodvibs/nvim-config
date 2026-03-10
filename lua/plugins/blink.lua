return {
    'saghen/blink.cmp',
    dependencies = {
        'rafamadriz/friendly-snippets',
        'echanovski/mini.icons',
        'nvim-tree/nvim-web-devicons'
    },

    version = 'v1.8',
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = { preset = 'default' },

        appearance = { nerd_font_variant = 'mono' },

        completion = {
            documentation = {
                auto_show = false,
                auto_show_delay_ms = 500,
            },
            menu = {
                auto_show = true,
            }
        },

        sources = {
            default = { 'lsp', 'path', 'omni' },
        },

        fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" }
}
