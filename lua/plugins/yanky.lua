return {
    "gbprod/yanky.nvim",
    opts = {},
    dependencies = { "folke/snacks.nvim" },
    keys = {
        {
            "<leader>yy",
            function()
                Snacks.picker.yanky()
            end,
            mode = { "n", "x" },
            desc = "Open Yank History",
        },
        {
            "<leader>yp",
            "<Plug>(YankyPreviousEntry)",
            desc = "Cycle previous yank",
        },
        {
            "<leader>yn",
            "<Plug>(YankyNextEntry)",
            desc = "Cycle next yank",
        }
    },
    config = {
        function()
            -- Yank ring usage
            vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
            vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
            vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
            vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

            vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
            vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")

            -- Paste with format
            vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
            vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
            vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
            vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

            vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
            vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
            vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
            vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

            vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
            vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")
        end
    }
}
