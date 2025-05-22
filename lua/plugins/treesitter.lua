return {
    "nvim-treesitter/nvim-treesitter",
    build = function()
        require("nvim-treesitter.install").update({ with_sync = true })()
        require("nvim-treesitter.configs").setup {
            ensure_installed = { "all" },
            sync_install = true,
            auto_install = true,
            ignore_install = {},
            modules = {}
        }
    end,
}
