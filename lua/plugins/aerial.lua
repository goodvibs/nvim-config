return {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "echasnovski/mini.icons"
    },
    config = function()
        require("aerial").setup({
            backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
            on_attach = function(bufnr)
                vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
                vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
            end,
        })
        vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
    end
}
