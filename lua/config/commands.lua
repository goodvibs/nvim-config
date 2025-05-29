vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- formatdisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
        vim.api.nvim_echo({ { "Autoformat disabled for the current buffer" }, }, true, {})
    else
        vim.g.disable_autoformat = true
        vim.api.nvim_echo({ { "Autoformat disabled globally" }, }, true, {})
    end
end, {
    desc = "Disable autoformat-on-save",
    bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    vim.api.nvim_echo({ { "Autoformat enabled globally" }, }, true, {})
end, {
    desc = "Enable autoformat-on-save",
})
