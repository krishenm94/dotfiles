" Sets
set relativenumber nu
set clipboard+=unnamedplus
set tabstop=4 softtabstop=4 noexpandtab shiftwidth=4 smarttab
set hidden
set history=1000
set incsearch nohlsearch
set errorbells
set nowrap
set nobackup noswapfile
set scrolloff=8
set signcolumn=yes
set colorcolumn=80

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ThePrimeagen/vim-be-good'
call plug#end()

"" Gruvbox
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_transparent_bg=1
colorscheme gruvbox

" Remaps and Leaders
let mapleader = " "

" Autocommands
fun! TrimWhitespace()
	let l:save = winsaveview()
	keeppatterns %s/\s\+$//e
	call winrestview(l:save)
endfun

augroup COMMANDS
	autocmd!
	autocmd BufWritePre * :call TrimWhitespace()
	" Workaround for transparent background
	autocmd SourcePost * highlight Normal     ctermbg=NONE guibg=NONE
            \ |    highlight LineNr     ctermbg=NONE guibg=NONE
            \ |    highlight SignColumn ctermbg=NONE guibg=NONE
augroup END

