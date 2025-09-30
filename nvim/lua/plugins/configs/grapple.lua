require("grapple").setup {
  -- Optional: Enable integration with nvim-web-devicons for file icons
  devicons = true,
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tag the current file
map('n', '<Leader>bmt', ':lua require("grapple").toggle()<CR>', vim.tbl_extend('force', opts, { desc = "Toggle Bookmark Tag" }))
map('n', '<Leader>bmT', ':lua require("grapple").tag()<CR>', vim.tbl_extend('force', opts, { desc = "Add Bookmark Tag" }))

-- Toggle the tag window
map('n', '<Leader>bmv', ':lua require("grapple").toggle_tags()<CR>', vim.tbl_extend('force', opts, { desc = "View Bookmarks" }))

-- Jump to the previous tag
map('n', '<Leader>bmp', ':lua require("grapple").jump("prev")<CR>', vim.tbl_extend('force', opts, { desc = "Previous Bookmark" }))

-- Jump to the next tag
map('n', '<Leader>bmn', ':lua require("grapple").jump("next")<CR>', vim.tbl_extend('force', opts, { desc = "Next Bookmark" }))

-- User command
-- vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>", { desc = "Jump to Bookmark 1" })
