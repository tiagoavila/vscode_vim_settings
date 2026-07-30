-- Setup Comment.nvim plugin

-- Arduino sketches (*.ino) resolve to the `arduino` filetype, which has no
-- Tree-sitter parser. On recent Neovim, `vim.treesitter.get_parser` returns
-- `nil` (instead of erroring) for such buffers, so Comment.nvim's Tree-sitter
-- integration dereferences a nil parser and crashes with a swallowed
-- `[Comment.nvim] nil` message -- before it ever falls back to `commentstring`.
-- Returning the comment string from `pre_hook` short-circuits that path.
-- Arduino code is C++, so use C-style comments.
local ARDUINO_FILETYPE = 'arduino'
local ARDUINO_LINE_COMMENT = '// %s'
local ARDUINO_BLOCK_COMMENT = '/* %s */'

---Provides the Arduino comment string, bypassing Comment.nvim's Tree-sitter
---lookup. Returns nil for every other filetype so default behavior is kept.
---@param ctx table Comment context, exposes the requested comment `ctype`.
---@return string|nil commentstring
local function arduino_commentstring(ctx)
    if vim.bo.filetype ~= ARDUINO_FILETYPE then
        return nil
    end

    local comment_utils = require('Comment.utils')
    if ctx.ctype == comment_utils.ctype.blockwise then
        return ARDUINO_BLOCK_COMMENT
    end

    return ARDUINO_LINE_COMMENT
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
    pre_hook = arduino_commentstring,
})

-- Also expose a native `commentstring`, so other tooling (e.g. mini.comment,
-- `:h commentstring`) formats Arduino comments correctly.
vim.api.nvim_create_autocmd('FileType', {
    pattern = ARDUINO_FILETYPE,
    callback = function()
        vim.bo.commentstring = ARDUINO_LINE_COMMENT
    end,
})
