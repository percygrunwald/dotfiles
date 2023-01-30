call plug#begin('~/.vim/plugged')
" ---> this is where you add your plugins <---

"{{ Configuring NerdTree
Plug 'scrooloose/nerdtree'
" Stop NERDTree opening when vim starts
  let NERDTreeHijackNetrw=0
" ---> to hide unwanted files <---
  let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]
" ---> show hidden files <---
  let NERDTreeShowHidden=1
" ---> autostart nerd-tree when you start vim <---
" Start NERDTree
" autocmd VimEnter * NERDTree
" " Jump to the main window.
" autocmd VimEnter * wincmd p"
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:stdn_in") | NERDTree | endif
" ---> toggling nerd-tree using Ctrl-N <---
  map <C-n> :NERDTreeToggle<CR>

" ---> Enable devicons with nerdtree  
" let g:webdevicons_enable_nerdtree = 1
" whether or not to show the nerdtree brackets around flags
" let g:webdevicons_conceal_nerdtree_brackets = 1
"}}

"{{ Configuring YouCompleteMe
"Plug 'valloric/youcompleteme', { 'do': './install.py' }


  " ---> youcompleteme configuration <---
"  let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'

" ---> compatibility with another plugin (ultisnips) <---
"let g:ycm_key_list_select_completion = [ '<C-n>', '<Down>' ]
"let g:ycm_key_list_previous_completion = [ '<C-p>', '<Up>' ]
"  let g:SuperTabDefaultCompletionType = '<C-n>'
" ---> disable preview window <---
"  set completeopt-=preview
" ---> navigating to the definition of a a symbol <---
"map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"}}

"{{ Configuring CtrlP
Plug 'ctrlpvim/ctrlp.vim'
"}}

"{{ Configuring UltiSnips
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"  let g:UltiSnipsExpandTrigger = "<tab>"
"  let g:UltiSnipsJumpForwardTrigger = "<tab>"
"  let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
"}}

"{{ Git integration
" ---> git commands within vim <---
" Plug 'tpope/vim-fugitive'
" ---> git changes on the gutter <---
Plug 'airblade/vim-gitgutter'
" ---> nerdtree git changes <---
Plug 'Xuyuanp/nerdtree-git-plugin'
" ---> vimdev icons  <---
"https://github.com/ryanoasis/vim-devicons
" Plug 'ryanoasis/vim-devicons'
" ---> vim-airline for status bar  <---
" https://github.com/vim-airline/vim-airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"}}

"{{ Color-scheme
Plug 'morhetz/gruvbox'
  set background=dark
"  colorscheme gruvbox
"  let g:gruvbox_contrast_dark='default'
"}}

"{{ Autopairs
" ---> closing XML tags <---
Plug 'alvan/vim-closetag'
" ---> files on which to activate tags auto-closing <---
  let g:closetag_filenames = '*.html,*.xhtml,*.xml,*.vue,*.phtml,*.js,*.jsx,*.coffee,*.erb'
" ---> closing braces and brackets <---
" Plug 'jiangmiao/auto-pairs'
"}}

"{{ TMux - Vim integration
Plug 'christoomey/vim-tmux-navigator'
"}}

"{{ GO Vim integration
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
"}}

call plug#end()

syntax on
filetype on
" filetype plugin indent on

set background=dark
set number
set nocompatible
set encoding=utf-8
"set tabstop=4
set foldlevelstart=20
set noshowmode
set ts=2 sw=3 sts=2 et
" set backspace=indent,eol,start
" set backspace=eol,start

"{{ Enable vim-airline tabline
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = "\u33c7"
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'

"}}

"{{ Enable fzf in vim
set rtp+=/usr/local/opt/fzf
"}}

if has("autocmd")
  autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd FileType go setlocal ts=2 sts=2 sw=2 expandtab noet nolist autowrite
endif

let g:indentLine_char = '⦙'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_lint_on_text_changed = 'never'

" Map <leader> to comma
let mapleader=","
map ,t :!make test<cr>
map ,m :!make<cr>
map ,v :!make validate<cr>
