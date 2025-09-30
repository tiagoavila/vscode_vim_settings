local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save files
keymap('n', '<leader>w', ':w<CR>', { noremap = opts.noremap, silent = opts.silent, desc = 'Save current buffer' })
keymap('n', '<leader>we', ':wa<CR>', { noremap = opts.noremap, silent = opts.silent, desc = 'Save all buffers' })

-- Paste without overwriting clipboard in visual mode
keymap('v', 'p', '"_dP', { noremap = opts.noremap, silent = opts.silent, desc = 'Paste without yanking' })

-- Change without yanking to clipboard
keymap({ 'n', 'v' }, '<leader>c', '"_c', { noremap = opts.noremap, silent = opts.silent, desc = 'Change without yanking' })
keymap({ 'n', 'v' }, '<leader>x', '"_x', { noremap = opts.noremap, silent = opts.silent, desc = 'Cut without yanking' })

-- Delete without yanking to clipboard
keymap({ 'n', 'v' }, '<leader>d', '"_d', { noremap = opts.noremap, silent = opts.silent, desc = 'Delete without yanking' })

-- Go to first/last non-blank character of line
keymap({ 'n', 'v' }, '<leader>h', '_', { noremap = opts.noremap, silent = opts.silent, desc = 'Go to first non-blank character' })
keymap({ 'n', 'v' }, '<leader>l', 'g_', { noremap = opts.noremap, silent = opts.silent, desc = 'Go to last non-blank character' })

-- Toggle case of current character
keymap({ 'n', 'v' }, '<leader>u', '~', { noremap = opts.noremap, silent = opts.silent, desc = 'Toggle case' })

-- Better indent handling
keymap("v", "<", "<gv", { noremap = opts.noremap, silent = opts.silent, desc = 'Indent line' })
keymap("v", ">", ">gv", { noremap = opts.noremap, silent = opts.silent, desc = 'Un-indent line' })

-- Remove highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", { noremap = opts.noremap, silent = opts.silent, desc = 'Exit and remove search highlight' })

-- Center screen when scrolling
keymap('n', '<C-d>', '<C-d>zz', { noremap = opts.noremap, silent = opts.silent, desc = 'Scroll down and center' })
keymap('n', '<C-u>', '<C-u>zz', { noremap = opts.noremap, silent = opts.silent, desc = 'Scroll up and center' })

-- Move text up and down
keymap({ 'n', 'v' }, "J", ":m .+1<CR>==", { noremap = opts.noremap, silent = opts.silent, desc = 'Move line down' })
keymap({ 'n', 'v' }, "K", ":m .-2<CR>==", { noremap = opts.noremap, silent = opts.silent, desc = 'Move line up' })
keymap("x", "J", ":move '>+1<CR>gv-gv", { noremap = opts.noremap, silent = opts.silent, desc = 'Move selection down' })
keymap("x", "K", ":move '<-2<CR>gv-gv", { noremap = opts.noremap, silent = opts.silent, desc = 'Move selection up' })

-- Enter visual block mode
keymap("n", "<leader>vb", "<C-v>", { noremap = opts.noremap, silent = opts.silent, desc = 'Enter visual block mode' })

-- Insert blank lines without entering insert mode
keymap('n', '<leader>o', 'o<Esc>', { desc = 'Insert blank line below' })
keymap('n', '<leader>O', 'O<Esc>', { desc = 'Insert blank line above' })

-- Quick replace word under cursor (selective with dot repeat)
-- * searches for word under cursor, `` returns to original position, 
-- cgn changes the next search match, then use n. to repeat on other occurrences
keymap('n', '<leader>x', '*``cgn', { desc = "Quick replace word under cursor (selective with dot repeat)" })

-- Join lines
keymap("n", "<leader>j", "J", { desc = "Join lines" })
keymap("n", "<leader>J", "gJ", { desc = "Join lines (no space)" })

-- Yank entire file
keymap("n", "<leader>ya", "ggVGy", { desc = "Yank entire file" })
keymap("n", "<leader>va", "ggVG", { desc = "Select entire file" })
