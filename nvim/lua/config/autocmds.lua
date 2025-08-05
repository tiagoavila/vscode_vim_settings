-- Remove auto-commenting
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    -- Remove 'o' and 'r' from formatoptions to disable auto-commenting
    -- o: automatically insert comment leader after 'o' or 'O'
    -- r: automatically insert comment leader after hitting Enter
    -- c: auto-wrap comments using textwidth
    -- t: auto-wrap text using textwidth (keep this if you want text wrapping)
    vim.opt.formatoptions:remove { "c", "r", "o" }
  end,
  desc = "Disable auto-commenting on new lines",
})

-- Customized highlight yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'Visual',
      timeout = 300,
      on_visual = true,
      on_macro = false,
    })
  end,
})
