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
    require("vscode_settings.keymaps")
else
    require("nvim_settings.keymaps")
end

-- ~/.config/nvim/
-- ├── init.lua                    (main entry point - minimal)
-- ├── init_backup.lua             (backup of previous config)
-- ├── lua/
-- │   ├── lsp.lua                 (LSP configuration)
-- │   ├── config/
-- │   │   ├── options.lua         (vim options and settings)
-- │   │   ├── keymaps.lua         (general keymaps for both environments)
-- │   │   └── autocmds.lua        (autocommands)
-- │   ├── plugins/
-- │   │   ├── init.lua            (plugin manager setup)
-- │   │   ├── common.lua          (plugins for both nvim and vscode)
-- │   │   ├── nvim-only.lua       (nvim-specific plugins)
-- │   │   └── configs/
-- │   │       ├── alpha-nvim.lua
-- │   │       ├── comment.lua
-- │   │       ├── grapple.lua
-- │   │       ├── hop-vim.lua
-- │   │       ├── nvim-cmp.lua
-- │   │       ├── nvim-tree.lua
-- │   │       ├── nvim-web-devicons.lua
-- │   │       ├── search-replace.lua
-- │   │       ├── telescope.lua
-- │   │       └── which-key.lua
-- │   ├── vscode_settings/
-- │   │   └── keymaps.lua         (vscode-specific mappings)
-- │   └── nvim_settings/
-- │       └── keymaps.lua         (nvim-specific mappings)
