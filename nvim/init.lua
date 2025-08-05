-- Set leader key to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Load configuration modules
require("config.options")
require("config.keymaps")
require("config.autocmds")
require("plugins")

-- Load environment-specific configurations
if vim.g.vscode then
    require("vscode.keymaps")
else
    require("nvim.keymaps")
end

-- ~/.config/nvim/
-- ├── init.lua                    (main entry point - minimal)
-- ├── lua/
-- │   ├── config/
-- │   │   ├── options.lua         (vim options and settings)
-- │   │   ├── keymaps.lua         (general keymaps for both environments)
-- │   │   └── autocmds.lua        (autocommands)
-- │   ├── plugins/
-- │   │   ├── init.lua            (plugin manager setup)
-- │   │   ├── common.lua          (plugins for both nvim and vscode)
-- │   │   ├── nvim-only.lua       (nvim-specific plugins)
-- │   │   └── configs/
-- │   │       ├── comment.lua
-- │   │       ├── nvim-tree.lua
-- │   │       ├── telescope.lua
-- │   │       ├── search-replace.lua
-- │   │       └── harpoon.lua
-- │   ├── vscode/
-- │   │   └── keymaps.lua         (vscode-specific mappings)
-- │   └── nvim/
-- │       └── keymaps.lua         (nvim-specific mappings)
