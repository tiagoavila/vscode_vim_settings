local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Save files
keymap('n', '<leader>w', ':w<CR>', opts)
keymap('n', '<leader>we', ':wa<CR>', opts)

-- Paste without overwriting clipboard in visual mode
keymap('v', 'p', '"_dP', opts)

-- Change without yanking to clipboard
keymap({ 'n', 'v' }, '<leader>c', '"_c', opts)
keymap({ 'n', 'v' }, '<leader>x', '"_x', opts)

-- Delete without yanking to clipboard
keymap({ 'n', 'v' }, '<leader>d', '"_d', opts)

-- Go to first/last non-blank character of line
keymap({ 'n', 'v' }, '<leader>h', '_', opts)
keymap({ 'n', 'v' }, '<leader>l', 'g_', opts)

-- Toggle case of current character
keymap({ 'n', 'v' }, '<leader>u', '~', opts)

-- Better indent handling
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Remove highlighting after escaping vim search
keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)

-- Center screen when scrolling
keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Move text up and down
keymap({ 'n', 'v' }, "J", ":m .+1<CR>==", opts)
keymap({ 'n', 'v' }, "K", ":m .-2<CR>==", opts)
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Enter visual block mode
keymap("n", "<leader>vb", "<C-v>", opts)

-- Insert blank lines without entering insert mode
keymap('n', '<leader>o', 'o<Esc>', { desc = 'Insert blank line below' })
keymap('n', '<leader>O', 'O<Esc>', { desc = 'Insert blank line above' })

-- Quick replace word under cursor (selective with dot repeat)
-- * searches for word under cursor, `` returns to original position, 
-- cgn changes the next search match, then use n. to repeat on other occurrences
keymap('n', '<leader>x', '*``cgn')

-- Join lines
keymap("n", "<leader>j", "J", { desc = "Join lines" })
keymap("n", "<leader>J", "gJ", { desc = "Join lines (no space)" })

-- Yank entire file
keymap("n", "<leader>ya", "ggVGy", { desc = "Yank entire file" })
