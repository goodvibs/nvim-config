function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

return {
  "akinsho/toggleterm.nvim",
  version="*",
  init = function()
    vim.keymap.set(
      "n",
      "<leader>tf",
      "<cmd>ToggleTerm direction=float<cr>",
      { desc = "ToggleTerm | Float Terminal", }
    )

    vim.keymap.set(
      "n",
      "<leader>th",
      "<cmd>ToggleTerm direction=horizontal<cr>",
      { desc = "ToggleTerm | Horizontal Terminal", }
    )

    vim.keymap.set(
      "n",
      "<leader>tv",
      "<cmd>ToggleTerm direction=vertical<cr>",
      { desc = "ToggleTerm | Vertical Terminal", }
    )

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  end,
  cmd = {
    "ToggleTerm",
  },
  opts = {
    size = function(term)
      if term.direction == "horizontal" then
        return vim.o.lines * 0.4
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    close_on_exit = true,
    direction =  'float',
    shell = vim.o.shell,
    float_opts = {
      border = "rounded",
      height = math.ceil(vim.o.lines * 1.0 - 4),
      width = math.ceil(vim.o.columns * 1.0),
      winblend = 0,
    },
  },
}
