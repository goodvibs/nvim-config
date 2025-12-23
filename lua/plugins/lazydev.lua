if not vim.env.VIMRUNTIME then
    local runtime_paths = {
        "/opt/homebrew/opt/neovim/share/nvim/runtime",
        "/usr/local/opt/neovim/share/nvim/runtime",
    }
    for _, path in ipairs(runtime_paths) do
        if vim.fn.isdirectory(path) == 1 then
            vim.env.VIMRUNTIME = path
            break
        end
    end
end

return {
    "folke/lazydev.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        library = {
            vim.fn.stdpath("config"),
            vim.fn.stdpath("data") .. "/lazy/snacks.nvim",
        },
        integrations = {
            lspconfig = true,
        },
    },
}
