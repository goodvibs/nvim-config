return {
    {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        opts = {
            style = "night",
            on_colors = function(colors)
                colors.fg_gutter = "#ff00ff"
            end,
        },
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
        end,
    },
}
