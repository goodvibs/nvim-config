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
        image = {
            enabled = true
        },
        bigfile = {
            enabled = true
        },
        gitbrowse = {
            enabled = true
        },
        scratch = {
            enabled = true
        }
    },
    keys = {
        { "<leader>gB", function() Snacks.gitbrowse() end,      desc = "Git Browse",           mode = { "n", "v" } },
        { "<leader>.",  function() Snacks.scratch() end,        desc = "Toggle Scratch Buffer" },
        { "<leader>S",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    },
    init = function()
        vim.api.nvim_create_autocmd("User", {
            pattern = "VeryLazy",
            callback = function()
                _G.dd = function(...)
                    Snacks.debug.inspect(...)
                end
                _G.bt = function()
                    Snacks.debug.backtrace()
                end
                vim.print = _G.dd

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
