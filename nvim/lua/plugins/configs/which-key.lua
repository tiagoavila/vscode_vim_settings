require("which-key").setup({
  -- your configuration comes here
  -- For example, to set the popup timeout
  -- timeout = 5000,
  -- your other configuration options...
    icons = {
        mappings = false,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "Ctrl ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
    }
})

-- The 'keys' section from the lazy.nvim config
-- This is how you create the custom mapping in Lua
vim.api.nvim_set_keymap('n', '<leader>?', ":lua require('which-key').show({ global = false })<CR>", { noremap = true, silent = true, desc = "Buffer Local Keymaps (which-key)" })
