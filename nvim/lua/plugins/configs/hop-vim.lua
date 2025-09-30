local hop = require("hop")
local directions = require("hop.hint").HintDirection

-- Setup Hop
hop.setup({
  keys = "etovxqpdygfblzhckisuran", -- default keys, can be customized
})

-- Custom highlights for hop hints
vim.api.nvim_set_hl(0, "HopNextKey", { fg = "#ff007c", bold = true })
vim.api.nvim_set_hl(0, "HopNextKey1", { fg = "#00dfff", bold = true })
vim.api.nvim_set_hl(0, "HopNextKey2", { fg = "#2b8db3" })
vim.api.nvim_set_hl(0, "HopUnmatched", { fg = "#666666" })

-- Silent/noremap mappings
local opts = { silent = true, noremap = true }

-- <leader><leader>w -> hop words forward
vim.keymap.set("n", "<leader><leader>w", function()
  hop.hint_words({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, vim.tbl_extend('force', opts, { desc = "Hop to Word Forward" }))

-- <leader><leader>b -> hop words backward
vim.keymap.set("n", "<leader><leader>b", function()
  hop.hint_words({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, vim.tbl_extend('force', opts, { desc = "Hop to Word Backward" }))

-- <leader><leader>j -> hop lines down
vim.keymap.set("n", "<leader><leader>j", function()
  hop.hint_lines({ direction = directions.AFTER_CURSOR })
end, vim.tbl_extend('force', opts, { desc = "Hop to Line Down" }))

-- <leader><leader>k -> hop lines up
vim.keymap.set("n", "<leader><leader>k", function()
  hop.hint_lines({ direction = directions.BEFORE_CURSOR })
end, vim.tbl_extend('force', opts, { desc = "Hop to Line Up" }))

-- <leader><leader>f -> hop to char forward
vim.keymap.set("n", "<leader><leader>f", function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
end, vim.tbl_extend('force', opts, { desc = "Hop to Character Forward" }))

-- <leader><leader>F -> hop to char backward
vim.keymap.set("n", "<leader><leader>F", function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
end, vim.tbl_extend('force', opts, { desc = "Hop to Character Backward" }))
