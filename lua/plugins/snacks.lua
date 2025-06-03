return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
        indent = {
            enabled = true
        },
        scope = {
            enabled = true
        },
        lazygit = {
            enabled = true
        },
        image = {
            enabled = true
        },
        input = {
            enabled = true
        },
        bigfile = {
            enabled = true
        },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                -- Setup some globals for debugging (lazy-loaded)
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd -- Override print to use snacks for `:=` command

                -- Create some toggle mappings
                Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>ow")
                Snacks.toggle.diagnostics():map("<leader>od")
                Snacks.toggle.treesitter():map("<leader>oT")
                Snacks.toggle.inlay_hints():map("<leader>oh")
                Snacks.toggle.indent():map("<leader>og")
                Snacks.toggle.dim():map("<leader>oD")
            end,
        })
    end
}
