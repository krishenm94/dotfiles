" Sets
set relativenumber nu
set clipboard+=unnamedplus
set tabstop=4 softtabstop=4 expandtab shiftwidth=4 smarttab
set history=1000
set incsearch
set ignorecase smartcase
set errorbells
set nowrap
set noswapfile
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

let mapleader=" "

" Remaps

nmap <C-k> <cmd>bn<cr>  " Jump to next buffer in list
nmap <C-j> <cmd>bp<cr>  " Jump to previous buffer in list
nmap <C-l> <C-^>    " Jump to previous visited buffer
nnoremap <leader>bo <cmd>w<bar>%bd<bar>e#<bar>bd#<cr> " Close all but current buffer

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

" telescope & dependencies
" External dependencies: ripgrep, fd
" :checkhealth telescope ;)
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'

Plug 'ThePrimeagen/vim-be-good'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go', {'do': ':GoUpdateBinaries'}
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'

" cosmetics
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'psliwka/vim-smoothie'

call plug#end()

source ~/.config/nvim/plug/coc.vim
source ~/.config/nvim/plug/telescope.vim

"" gruvbox
let g:gruvbox_contrast_dark='medium'
let g:gruvbox_transparent_bg=1
colorscheme gruvbox

"" vim-smoothie
let g:smoothie_speed_linear_factor = 12
let g:smoothie_speed_constant_factor = 15

"" airline
let airline_theme='deus'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#coc#enabled = 1

<<<<<<< HEAD
"" vim-fugitive
nmap <leader>gg <cmd>tab G<CR>

"" nerdtree
let g:NERDTreeShowHidden=1
=======
" gopls is hanging while loading packages on work mac
let g:go_gopls_enabled = 0
>>>>>>> f6b58e6 (gopls hanging)
