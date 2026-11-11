-- Setup Comment.nvim plugin

-- Most filetypes used here (typescript, html, less, json, cs, arduino...) have no
-- Tree-sitter parser installed. On Neovim 0.11+, `vim.treesitter.get_parser`
-- returns `nil` (instead of erroring) for such buffers, so Comment.nvim's
-- Tree-sitter integration dereferences a nil parser and crashes with a swallowed
-- `[Comment.nvim] nil` message -- before it ever falls back to its filetype table.
-- Returning the comment string from `pre_hook` short-circuits that path.
local comment_ft = require('Comment.ft')

-- Arduino sketches (*.ino) resolve to the `arduino` filetype, which Comment.nvim
-- does not know. Arduino code is C++, so use C-style comments.
local ARDUINO_FILETYPE = 'arduino'
local ARDUINO_LINE_COMMENT = '// %s'
local ARDUINO_BLOCK_COMMENT = '/* %s */'

comment_ft.set(ARDUINO_FILETYPE, { ARDUINO_LINE_COMMENT, ARDUINO_BLOCK_COMMENT })

-- Less supports both `//` and `/* */`, but Comment.nvim has no `less` entry.
comment_ft.set('less', { '// %s', '/* %s */' })

---Reports whether the current buffer has a Tree-sitter parser.
---On Neovim 0.11+ `get_parser` returns nil instead of raising when none exists.
---@return boolean
local function has_treesitter_parser()
    local ok, parser = pcall(vim.treesitter.get_parser, 0)
    return ok and parser ~= nil
end

---Resolves the comment string without Tree-sitter for buffers that have no parser.
---Returns nil when a parser exists, so Comment.nvim keeps its Tree-sitter behavior.
---@param ctx table Comment context, exposes the requested comment `ctype`.
---@return string|nil commentstring
local function commentstring_without_treesitter(ctx)
    if has_treesitter_parser() then
        return nil
    end

    local filetype_commentstring = comment_ft.get(vim.bo.filetype, ctx.ctype)
    if filetype_commentstring then
        return filetype_commentstring
    end

    -- Returning nil here would reach the nil parser again, so Neovim's own
    -- `commentstring` is used for both line and block comments.
    if vim.bo.commentstring ~= '' then
        return vim.bo.commentstring
    end

    return nil
end

require('Comment').setup({
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = 'gcc',
        ---Block-comment toggle keymap
        block = 'gbc',
    },
    extra = {
        ---Add comment on the line above
        above = 'gcO',
        ---Add comment on the line below
        below = 'gco',
        ---Add comment at the end of line
        eol = 'gcA',
    },
    -- ignores empty lines
    ignore = '^$',
    -- resolves the comment string for filetypes without a Tree-sitter parser
    pre_hook = commentstring_without_treesitter,
})

-- Also expose a native `commentstring`, so other tooling (e.g. mini.comment,
-- `:h commentstring`) formats Arduino comments correctly.
vim.api.nvim_create_autocmd('FileType', {
    pattern = ARDUINO_FILETYPE,
    callback = function()
        vim.bo.commentstring = ARDUINO_LINE_COMMENT
    end,
})
