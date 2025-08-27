require("grapple").setup {
  -- Optional: Enable integration with nvim-web-devicons for file icons
  devicons = true,
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- Tag the current file
map('n', '<Leader>gt', ':lua require("grapple").toggle()<CR>', opts)
map('n', '<Leader>gT', ':lua require("grapple").tag()<CR>', opts)

-- Toggle the tag window
map('n', '<Leader>gw', ':lua require("grapple").toggle_tags()<CR>', opts)

-- Jump to the previous tag
map('n', '<Leader>gp', ':lua require("grapple").jump("prev")<CR>', opts)

-- Jump to the next tag
map('n', '<Leader>gn', ':lua require("grapple").jump("next")<CR>', opts)
-- User command
-- vim.keymap.set("n", "<leader>1", "<cmd>Grapple select index=1<cr>")
