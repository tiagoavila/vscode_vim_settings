vim.cmd [[
  call plug#begin()
]]

-- Load common plugins (available in both environments)
require("plugins.common")

-- Load nvim-only plugins when not in vscode
if not vim.g.vscode then
    require("plugins.nvim-only")
end

vim.cmd [[
  call plug#end()
]]

-- Setup common plugins
require("plugins.configs.comment")
require("plugins.configs.hop-vim")

-- Setup nvim-only plugins
if not vim.g.vscode then
    require("plugins.configs.nvim-tree")
    require("plugins.configs.telescope")
    require("plugins.configs.search-replace")
    require("plugins.configs.grapple")
    require("plugins.configs.which-key")
    require("plugins.configs.nvim-web-devicons")
end
