" Set search to ignore case by default
set ignorecase
set smartcase

"Set search to highlight results
set hlsearch

" Set relative and fixed row number
set number relativenumber

" Set a leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Remap <Leader>s to save the file
nnoremap <leader>s :w<CR>
nnoremap <leader>w :w<CR>

" Remap <Leader>sa to save all files
nnoremap <leader>sa :wa<CR>

" Remap <Leader>we to save all files
nnoremap <leader>we :wa<CR>

" Custom mapping to replace all occurrences of the word under the cursor
nnoremap <leader>r :%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>

" Custom mapping to replace completely all occurrences of the word under the cursor, this one starts with an empty replacement
nnoremap <leader>rt :%s/\<<C-r><C-w>\>//g<Left><Left>

" Custom Mapping to insert text at the end of word under the cursor
nnoremap <leader>e ea

" paste text without overwriting the clipboard
xnoremap <leader>p "\"_dP"

" Black hole change mapping - that prevents copying the content when changing a text
nnoremap <leader>c "_c
vnoremap <leader>c "_c

" Black hole delete mapping - that prevents copying the content when deleting a text
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Mapping to go to the first non-blank character of the line
nnoremap <leader>h ^

"Toggle the case of the letter under the cursor in normal mode.
nnoremap <leader>u ~

"Toggles the case for the visually selected text in visual mode.
vnoremap <leader>u g~`

" Yank the current line or a range to the clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

nnoremap <leader>pe "+p
vnoremap <leader>pe "+p

nnoremap <leader>x *``cgn

" Close active tab
nnoremap <leader>q :tabclose<CR>

" Map 'jj' to exit insert mode
inoremap jj <Esc>

" Map 'jk' to exit insert mode and save changes
inoremap jk <Esc>:w<CR>

" Map leader o to go back in jumps
nnoremap <leader>o <C-o>