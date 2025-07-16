-- require("config.lazy")

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
    Plug 'numToStr/Comment.nvim'
    Plug 'roobert/search-replace.nvim'
  call plug#end()
]]

-- Setup Comment.nvim plugin
require('Comment').setup({
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    -- ignores empty lines
    ignore = '^$'
})

require("search-replace").setup({
    default_replace_single_buffer_options = "gcI",
    default_replace_multi_buffer_options = "egcI",
})

-- Mappings for the search-replace plugin
local opts_search_replace = {}
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts_search_replace)
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts_search_replace)

vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", opts_search_replace)

-- show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

-- Set up vim options for case handling
vim.opt.ignorecase = true
vim.opt.smartcase = true -- If searched 'abc' matches abc, Abc, ABC, etc. - if searched 'Abc', matches Abc (case-sensitive)

-- Remove auto-commenting
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Remove 'o' and 'r' from formatoptions to disable auto-commenting
    -- o: automatically insert comment leader after 'o' or 'O'
    -- r: automatically insert comment leader after hitting Enter
    -- c: auto-wrap comments using textwidth
    -- t: auto-wrap text using textwidth (keep this if you want text wrapping)
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  desc = "Disable auto-commenting on new lines",
})

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
keymap({ 'n', 'v' }, '<leader>c', '"_c', opts)

-- Delete without yanking to clipboard
keymap({ 'n', 'v' }, '<leader>d', '"_d', opts)

-- Go to first non-blank character of line
keymap({ 'n', 'v' }, '<leader>h', '_', opts)

-- Go to last non-blank character of line
keymap({ 'n', 'v' }, '<leader>l', 'g_', opts)

-- Toggle case of current character in normal and visual mode
keymap({ 'n', 'v' }, '<leader>u', '~', opts)

-- better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- removes highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- move text up and down
keymap({ 'n', 'v' }, "J", ":m .+1<CR>==", opts)
keymap({ 'n', 'v' }, "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- enter visual block mode
keymap("n", "<leader>vb", "<C-v>", { noremap = true, silent = true })

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

    -- Breakpoint operations (b prefix)
    keymap({"n", "v"}, "<leader>bt", function() vscode.action('editor.debug.action.toggleBreakpoint') end, opts)
    keymap({"n", "v"}, "<leader>br", function() vscode.action('workbench.debug.viewlet.action.removeAllBreakpoints') end, opts)

    -- Debug operations (d prefix)
    keymap({"n", "v"}, "<leader>ds", function() vscode.action('workbench.action.debug.start') end, opts)
    keymap({"n", "v"}, "<leader>dw", function() vscode.action('editor.debug.action.selectionToWatch') end, opts)

    -- View operations (v prefix)
    keymap({"n", "v"}, "<leader>vp", function() vscode.action('workbench.actions.view.problems') end, opts)
    
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
    keymap({"n", "v"}, "<leader>esr", function() vscode.action('workbench.action.splitEditorRight') end, opts)
    keymap({"n", "v"}, "<leader>esl", function() vscode.action('workbench.action.focusLeftGroup') end, opts)
    keymap({"n", "v"}, "<leader>emr", function() vscode.action('workbench.action.moveEditorToRightGroup') end, opts)
    keymap({"n", "v"}, "<leader>eml", function() vscode.action('workbench.action.moveEditorToLeftGroup') end, opts)
    keymap({"n", "v"}, "<leader>efr", function() vscode.action('workbench.action.focusRightGroup') end, opts)
    keymap({"n", "v"}, "<leader>efl", function() vscode.action('workbench.action.focusLeftGroup') end, opts)
else
    -- ordinary Neovim
    keymap('i', 'jj', '<Esc>', opts)
    keymap('i', 'jk', '<Esc>:w<CR>', opts)
end
