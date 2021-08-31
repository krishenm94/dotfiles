" Sets
set relativenumber nu
set clipboard+=unnamedplus
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
set history=1000
set incsearch nohlsearch
set ignorecase smartcase
set errorbells
set nowrap
set noswapfile
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

" Plugins
call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ThePrimeagen/vim-be-good'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

source ~/.config/nvim/plug/coc.vim

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

" Might be better to replace this with a treesitter or lsp config
augroup SYNTAX_HIGHTLIGHTING
	autocmd BufRead,BufNewFile .aliasrc set ft=sh
	autocmd BufRead,BufNewFile .functionrc set ft=sh
augroup END

" Commands

function! ClearRegisters()
    let regs='abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789/-="*+'
    let i=0
    while (i<strlen(regs))
        exec 'let @'.regs[i].'=""'
        let i=i+1
    endwhile
endfunction

command! ClearRegisters call ClearRegisters()
