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

" Remaps and Leaders
let mapleader=" "

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
	autocmd BufRead,BufNewFile .envrc set ft=sh
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

" Plugins

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')
let curl_exists=expand('curl')
if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/plugged')
Plug 'nvim-telescope/telescope.nvim'
Plug 'psliwka/vim-smoothie'
Plug 'morhetz/gruvbox'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ThePrimeagen/vim-be-good'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'fatih/vim-go'
call plug#end()

source ~/.config/nvim/plug/coc.vim

"" gruvbox
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_transparent_bg=1
colorscheme gruvbox

"" vim-smoothie
let g:smoothie_speed_linear_factor = 12
let g:smoothie_speed_constant_factor = 15

