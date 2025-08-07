" Set search to ignore case by default
set ignorecase
set smartcase

"Set search to highlight results
set hlsearch

" Set relative and fixed row number
set number relativenumber

set clipboard=unnamedplus

" Set a leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" Remap <Leader>w and <Leader>we to save the files
nnoremap <leader>w :w<CR>
nnoremap <leader>we :wa<CR>

" Custom mapping to replace completely all occurrences of the word under the cursor, this one starts with an empty replacement
nnoremap <leader>rw :%s/\<<C-r><C-w>\>//g<Left><Left>
xnoremap <leader>rs :s///gc<Left><Left><Left><Left>

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

nnoremap <leader>l $
vnoremap <leader>l $

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

" Map 'jj' to exit insert mode
inoremap jj <Esc>

" Map 'jk' to exit insert mode and save changes
inoremap jk <Esc>:w<CR>

" Map leader o to go back in jumps
"nnoremap <leader>o <C-o>

nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Move current line or selected lines up with K
nnoremap K :m .-2<CR>==
vnoremap K :m '<-2<CR>gv=gv

" Move current line or selected lines down with J
nnoremap J :m .+1<CR>==
vnoremap J :m '>+1<CR>gv=gv

" enter visual block mode
nnoremap <leader>vb <C-v>

" better indent handling
vnoremap < <gv
vnoremap > >gv

" Insert blank line below without entering insert mode
nnoremap <leader>o o<Esc>

" Insert blank line above without entering insert mode  
nnoremap <leader>O O<Esc>

" Join current line with the one below
nnoremap <leader>j J

" Join without adding a space (optional)
nnoremap <leader>J gJ

" Yank all content of file
nnoremap <leader>ya ggVGy

" Paste without overwriting clipboard in visual mode
xnoremap p "_dP
