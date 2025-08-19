-- Set up vim options for case handling
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Enable line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse support
vim.o.mouse = 'a'

-- Use system clipboard
vim.o.clipboard = 'unnamedplus'

-- Set tab behavior
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4

-- Configure vim-sneak
vim.g['sneak#use_ic_scs'] = 1
vim.g['sneak#prompt'] = ''
