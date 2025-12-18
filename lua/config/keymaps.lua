local keymap = vim.keymap

-- Autoformat toggle keymaps
keymap.set("n", "<leader>mT", function()
    local is_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat
    vim.g.disable_autoformat = not is_disabled
    vim.b.disable_autoformat = nil -- Clear buffer-local override
    local status = vim.g.disable_autoformat and "disabled" or "enabled"
    vim.notify(string.format("Autoformat %s globally", status), vim.g.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO)
end, { desc = "Toggle autoformat globally" })

keymap.set("n", "<leader>mt", function()
    local is_disabled = vim.g.disable_autoformat or vim.b.disable_autoformat
    vim.b.disable_autoformat = not is_disabled
    local status = vim.b.disable_autoformat and "disabled" or "enabled"
    vim.notify(string.format("Autoformat %s for current buffer", status), vim.b.disable_autoformat and vim.log.levels.WARN or vim.log.levels.INFO)
end, { desc = "Toggle autoformat for buffer" })

keymap.set("n", "<leader>ms", "<cmd>FormatStatus<cr>", { desc = "Show format status" })
