vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.options")

-- Autoformat toggle commands
vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
        -- FormatDisable! disables formatting just for this buffer
        vim.b.disable_autoformat = true
        vim.api.nvim_echo({
            { "Autoformat disabled for current buffer", "WarningMsg" },
        }, true, {})
    else
        -- FormatDisable disables formatting globally
        vim.g.disable_autoformat = true
        vim.api.nvim_echo({
            { "Autoformat disabled globally", "WarningMsg" },
        }, true, {})
    end
end, {
    desc = "Disable autoformat-on-save (use ! for buffer-only)",
    bang = true,
})

vim.api.nvim_create_user_command("FormatEnable", function(args)
    if args.bang then
        -- FormatEnable! enables formatting just for this buffer
        vim.b.disable_autoformat = false
        vim.api.nvim_echo({
            { "Autoformat enabled for current buffer", "SuccessMsg" },
        }, true, {})
    else
        -- FormatEnable enables formatting globally
        vim.g.disable_autoformat = false
        vim.b.disable_autoformat = nil -- Clear buffer-local override
        vim.api.nvim_echo({
            { "Autoformat enabled globally", "SuccessMsg" },
        }, true, {})
    end
end, {
    desc = "Enable autoformat-on-save (use ! for buffer-only)",
    bang = true,
})

vim.api.nvim_create_user_command("FormatToggle", function(args)
    local is_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat
    if args.bang then
        -- Toggle for current buffer only
        vim.b.disable_autoformat = not is_disabled
        local status = vim.b.disable_autoformat and "disabled" or "enabled"
        vim.api.nvim_echo({
            { string.format("Autoformat %s for current buffer", status), vim.b.disable_autoformat and "WarningMsg" or "SuccessMsg" },
        }, true, {})
    else
        -- Toggle globally
        vim.g.disable_autoformat = not is_disabled
        vim.b.disable_autoformat = nil -- Clear buffer-local override
        local status = vim.g.disable_autoformat and "disabled" or "enabled"
        vim.api.nvim_echo({
            { string.format("Autoformat %s globally", status), vim.g.disable_autoformat and "WarningMsg" or "SuccessMsg" },
        }, true, {})
    end
end, {
    desc = "Toggle autoformat-on-save (use ! for buffer-only)",
    bang = true,
})

vim.api.nvim_create_user_command("FormatStatus", function()
    local global_status = vim.g.disable_autoformat and "disabled" or "enabled"
    local buffer_status = vim.b.disable_autoformat and "disabled" or "enabled"
    local effective_status = (vim.g.disable_autoformat or vim.b.disable_autoformat) and "disabled" or "enabled"

    vim.api.nvim_echo({
        { "Autoformat Status:\n",                             "Title" },
        { string.format("  Global: %s\n", global_status),     global_status == "disabled" and "WarningMsg" or "SuccessMsg" },
        { string.format("  Buffer: %s\n", buffer_status),     buffer_status == "disabled" and "WarningMsg" or "SuccessMsg" },
        { string.format("  Effective: %s", effective_status), effective_status == "disabled" and "WarningMsg" or "SuccessMsg" },
    }, true, {})
end, {
    desc = "Show autoformat status",
})


local keymap = vim.keymap

-- Autoformat toggle keymaps
keymap.set("n", "<leader>mT", function()
    local is_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat
    vim.g.disable_autoformat = not is_disabled
    vim.b.disable_autoformat = nil -- Clear buffer-local override
    local status = vim.g.disable_autoformat and "disabled" or "enabled"
    vim.notify(string.format("Autoformat %s globally", status),
        vim.g.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO)
end, { desc = "Toggle autoformat globally" })

keymap.set("n", "<leader>mt", function()
    local is_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat
    vim.b.disable_autoformat = not is_disabled
    local status = vim.b.disable_autoformat and "disabled" or "enabled"
    vim.notify(string.format("Autoformat %s for current buffer", status),
        vim.b.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO)
end, { desc = "Toggle autoformat for buffer" })

keymap.set("n", "<leader>ms", "<cmd>FormatStatus<cr>", { desc = "Show format status" })
