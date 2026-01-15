require("grapple").setup {
  -- Optional: Enable integration with nvim-web-devicons for file icons
  devicons = true,
}

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

