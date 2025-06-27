local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd [[
  call plug#begin()
  Plug 'justinmk/vim-sneak'
  Plug 'tpope/vim-surround'
  Plug 'easymotion/vim-easymotion'
  call plug#end()
]]

-- Set up vim options for case handling
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.formatoptions:remove({ 'o' })

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

-- Configure vim-sneak to use ignore case
vim.g['sneak#use_ic_scs'] = 1
vim.g['sneak#prompt'] = ''  -- Remove prompt to avoid output

-- Save files
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>we', ':wa<CR>', opts)

-- Paste without overwriting clipboard in visual mode
keymap('v', 'p', '"_dP', opts)

-- Change without yanking to clipboard
keymap('n', '<leader>c', '"_c', opts)
keymap('v', '<leader>c', '"_c', opts)

-- Delete without yanking to clipboard
keymap('n', '<leader>d', '"_d', opts)
keymap('v', '<leader>d', '"_d', opts)

-- Go to first non-blank character of line
keymap({ 'n', 'v' }, '<leader>h', '_', opts)

-- Go to last non-blank character of line
keymap({ 'n', 'v' }, '<leader>l', 'g_', opts)

-- Toggle case of current character in normal and visual mode
keymap('n', '<leader>u', '~', opts)
keymap('v', '<leader>u', 'g~`', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Customized highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Visual',    -- Highlight group to use (default: 'IncSearch')
      timeout = 300,         -- Time in milliseconds (default: 150)
      on_visual = true,      -- Highlight when yanking in visual mode (default: true)
      on_macro = false,      -- Highlight when recording macros (default: false)
    })
  end,
})

-- Diferent settings for nvim on VSCode/Cursor
if vim.g.vscode then
    -- VSCode extension
    local vscode = require("vscode")

    -- Code navigation
    keymap({"n", "v"}, "<leader>ff", function() vscode.action('editor.action.quickFix') end, opts)
    keymap({"n", "v"}, "gq", function() vscode.action('editor.action.quickFix') end, opts)
    keymap({"n", "v"}, "gi", function() vscode.action('editor.action.goToImplementation') end, opts)
    keymap({"n", "v"}, "gpi", function() vscode.action('editor.action.peekImplementation') end, opts)
    keymap({"n", "v"}, "gr", function() vscode.action('editor.action.referenceSearch.trigger') end, opts)

    keymap({"n", "v"}, '<leader>fd', function() vscode.action('editor.action.formatDocument') end, opts)
    keymap({"n", "v"}, "<leader>q", function() vscode.action('workbench.action.closeActiveEditor')end, opts)

    -- Breakpoint operations (b prefix)
    keymap({"n", "v"}, "<leader>bt", function() vscode.action('editor.debug.action.toggleBreakpoint') end, opts)
    keymap({"n", "v"}, "<leader>br", function() vscode.action('workbench.debug.viewlet.action.removeAllBreakpoints') end, opts)

    -- View operations (v prefix)
    keymap({"n", "v"}, "<leader>vp", function() vscode.action('workbench.actions.view.problems') end, opts)
    keymap({"n", "v"}, "<leader>vc", function() vscode.action('workbench.action.showCommands') end, opts)
    keymap({"n", "v"}, "<leader>ve", function() vscode.action('workbench.view.explorer') end, opts)
    keymap({"n", "v"}, "<leader>vt", function() vscode.action('workbench.action.togglePanel') end, opts)
    
    -- File operations (f prefix)
    keymap({"n", "v"}, "<leader>fs", function() vscode.action('workbench.action.findInFiles') end, opts)
    keymap({"n", "v"}, "<leader>fr", function() vscode.action('workbench.action.replaceInFiles') end, opts)

    -- Tab navigation (t prefix)
    keymap({"n", "v"}, '<leader>tp', function() vscode.action('workbench.action.previousEditor') end, opts)
    keymap({"n", "v"}, '<leader>tn', function() vscode.action('workbench.action.nextEditor') end, opts)
    keymap({"n", "v"}, "<leader>tf", function() vscode.action('workbench.action.firstEditorInGroup') end, opts)
    keymap({"n", "v"}, "<leader>tl", function() vscode.action('workbench.action.lastEditorInGroup') end, opts)

    -- Rename and refactor
    keymap({"n", "v"}, "<leader>rn", function() vscode.action('editor.action.rename') end, opts)
    keymap({"n", "v"}, "<leader>rr", function() vscode.action('editor.action.refactor') end, opts)

    -- Editor management (e prefix)
    keymap({"n", "v"}, "<leader>er", function() vscode.action('workbench.action.splitEditorRight') end, opts)
    keymap({"n", "v"}, "<leader>el", function() vscode.action('workbench.action.focusLeftGroup') end, opts)
    keymap({"n", "v"}, "<leader>efr", function() vscode.action('workbench.action.focusRightGroup') end, opts)

else
    -- ordinary Neovim

    keymap('i', 'jj', '<Esc>', opts)
    keymap('i', 'jk', '<Esc>:w<CR>', opts)
end
