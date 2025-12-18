vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.expand("~") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 6
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- Better completion experience
vim.opt.completeopt = { "menuone", "noselect" } -- Show popup menu even for one match, don't auto-select

-- Better search experience
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true -- Override ignorecase if search contains uppercase

-- Better visual feedback
vim.opt.cursorline = true -- Highlight current line

-- Better command line
vim.opt.showcmd = true -- Show partial commands in status line
vim.opt.wildmenu = true -- Enhanced command-line completion

-- Better file handling
vim.opt.hidden = true -- Allow hidden buffers (don't require saving before switching)
vim.opt.autoread = true -- Auto-reload files changed outside vim

-- Better performance
vim.opt.lazyredraw = false -- Don't redraw during macro execution (can cause issues)
vim.opt.synmaxcol = 300 -- Don't syntax highlight lines longer than 300 chars

-- Better status
vim.opt.laststatus = 2 -- Always show status line
vim.opt.ruler = false -- Don't show cursor position (handled by statusline plugins)

-- Better folding (if you use folds)
vim.opt.foldmethod = "indent" -- Fold based on indentation
vim.opt.foldlevel = 99 -- Don't fold by default

-- Better list chars (show whitespace)
vim.opt.list = false -- Don't show list chars by default (toggle with :set list!)
vim.opt.listchars = { tab = "→ ", eol = "↲", nbsp = "␣", trail = "•", extends = "⟩", precedes = "⟨" }

-- Better timeouts
vim.opt.timeoutlen = 300 -- Time to wait for mapped sequence to complete
vim.opt.ttimeoutlen = 0 -- Time to wait for key code sequence to complete
