local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Insert mode mappings (nvim-only)
keymap('i', 'jj', '<Esc>', opts)
keymap('i', 'jk', '<Esc>:w<CR>', opts)

-- File explorer mappings (f prefix)
keymap("n", "<leader>ve", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle File Explorer" })
keymap("n", "<leader>fe", "<cmd>NvimTreeFocus<CR>", { desc = " Open the tree if it is closed, and then focus on the tree." })
keymap("n", "<leader>vE", function()
    local api = require("nvim-tree.api")
    local path = vim.fn.expand('%:p:h')
    vim.cmd('cd ' .. path)
    api.tree.open()
end, { desc = "Open File Explorer in Current File's Folder" })

-- Project mappings using telescope (p prefix)    
keymap("n", "<leader>pf", "<cmd>Telescope find_files<CR>", { desc = "Project Files" })
keymap("n", "<leader>pr", "<cmd>Telescope oldfiles<CR>", { desc = "Project Recent Files" })
keymap("n", "<leader>pb", "<cmd>Telescope buffers<CR>", { desc = "Project Buffers" })

local opts_search_replace = {}
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts_search_replace)
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts_search_replace)

vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts_search_replace)
vim.api.nvim_set_keymap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", opts_search_replace)

