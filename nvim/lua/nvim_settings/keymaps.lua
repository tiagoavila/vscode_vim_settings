local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Insert mode mappings (nvim-only)
keymap('i', 'jj', '<Esc>', { noremap = true, silent = true, desc = "Exit Insert Mode" })
keymap('i', 'jk', '<Esc>:w<CR>', { noremap = true, silent = true, desc = "Exit Insert Mode and Save" })

-- File explorer mappings (f prefix) - nvim-tree
keymap("n", "<leader>ve", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
keymap("n", "<leader>fe", "<cmd>NvimTreeFocus<CR>", { desc = "Open the tree if it is closed, and then focus on the tree." })
keymap("n", "<leader>vE", function()
    local api = require("nvim-tree.api")
    local path = vim.fn.expand('%:p:h')
    vim.cmd('cd ' .. path)
    api.tree.open()
end, { desc = "Open File Explorer in Current File's Folder" })

-- Project mappings using telescope (p prefix) - Telescope, a highly extendable fuzzy finder over lists  
keymap("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "Project Files" })
keymap("n", "<leader>pr", "<cmd>Telescope oldfiles<CR>", { desc = "Project Recent Files" })
keymap("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "Project Buffers" })

-- Search and Replace mappings (r prefix) - search-replace
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", { desc = "Search & Replace in Visual Selection" })
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", { desc = "Search & Replace Current Word in Visual Selection" })

vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", { desc = "Search & Replace in Buffer Selections" })
vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", { desc = "Search & Replace Open in Buffer" })
vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", { desc = "Search & Replace Current Word in Buffer" })
vim.api.nvim_set_keymap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", { desc = "Search & Replace Current WORD in Buffer" })
vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", { desc = "Search & Replace Current Expression in Buffer" })
vim.api.nvim_set_keymap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", { desc = "Search & Replace Current File Path in Buffer" })

-- Tag the current file - grapple
vim.api.nvim_set_keymap('n', '<Leader>bmt', ':lua require("grapple").toggle()<CR>', vim.tbl_extend('force', opts, { desc = "Toggle Bookmark Tag" }))
vim.api.nvim_set_keymap('n', '<Leader>bmT', ':lua require("grapple").tag()<CR>', vim.tbl_extend('force', opts, { desc = "Add Bookmark Tag" }))

-- Toggle the tag window
vim.api.nvim_set_keymap('n', '<Leader>bmv', ':lua require("grapple").toggle_tags()<CR>', vim.tbl_extend('force', opts, { desc = "View Bookmarks" }))

-- Jump to the previous tag
vim.api.nvim_set_keymap('n', '<Leader>bmp', ':lua require("grapple").jump("prev")<CR>', vim.tbl_extend('force', opts, { desc = "Previous Bookmark" }))

-- Jump to the next tag
vim.api.nvim_set_keymap('n', '<Leader>bmn', ':lua require("grapple").jump("next")<CR>', vim.tbl_extend('force', opts, { desc = "Next Bookmark" }))

-- User command
-- vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>", { desc = "Jump to Bookmark 1" })
