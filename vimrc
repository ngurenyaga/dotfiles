set nocompatible              " turn off vi compatibility
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim' " package manager
Plugin 'vim-scripts/indentpython.vim' " indentation script for Python
Plugin 'vim-syntastic/syntastic' " syntax checking for Vim
Plugin 'altercation/vim-colors-solarized' " color scheme
Plugin 'ctrlpvim/ctrlp.vim' " fuzzy file finder
Plugin 'tpope/vim-fugitive' " git wrapper
Plugin 'tmux-plugins/vim-tmux-focus-events' " restore FocusGained and FocusLost events when working in tmux
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'} " improved status line for Vim
Plugin 'ambv/black' " opinionated Python code formatter
Plugin 'Quramy/tsuquyomi' " Typescript language server plugin
Plugin 'leafgarland/typescript-vim' " Typescript syntax files for Vim
Plugin 'pangloss/vim-javascript' " Javascript indentation and syntax
Plugin 'scrooloose/nerdtree' " file navigation tool
Plugin 'bronson/vim-trailing-whitespace' " highlight trailing whitespace
Plugin 'airblade/vim-gitgutter' " show git diff in gutter
Plugin 'tpope/vim-obsession' " automatically updated Vim session files
Plugin 'tmux-plugins/vim-tmux' " tmux configuration file syntax support
Plugin 'christoomey/vim-tmux-navigator' " use the same nav keys on vim and tmux
Plugin 'gabesoft/vim-ags' " silver searcher support
Plugin 'heavenshell/vim-pydocstring'  " generation of Python docstrings
Plugin 'w0rp/ale' " asynchronous linting engine
Plugin 'christoomey/vim-tmux-runner' " integrate Vim and tmux
Plugin 'tpope/vim-commentary' " comment and uncomment stuff
Plugin 'scrooloose/nerdcommenter' " another plugin to comment and uncomment
Plugin 'tpope/vim-surround' " simplify surrounding code

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required

" enable syntax highlighting
syntax enable

" show line numbers
set number

" relative numbers
set relativenumber

" set tabs to have 4 spaces
set ts=4

" indent when moving to the next line while writing code
set autoindent

" expand tabs into spaces
set expandtab

" when using the >> or << commands, shift lines by 4 spaces
set shiftwidth=4

" show a visual line under the cursor's current line
set cursorline

" show the matching part of the pair for [] {} and ()
set showmatch

" use UTF-8 encoding
set encoding=utf-8

" enable all Python syntax highlighting features
let python_highlight_all = 1

" hide the Gvim menu bar, toolbar, right scrollbar and left scrollbar
" also set the font to a smaller size
if has('gui_running')
  set guifont=Ubuntu\ Mono\ 8
  set guioptions-=m
  set guioptions-=T
  set guioptions-=R
  set guioptions-=L
endif

colorscheme solarized
set background=dark

"python with virtualenv support
py3 << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
  project_base_dir = os.environ['VIRTUAL_ENV']
  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
  exec(open(activate_this).read(), dict(__file__=activate_this))
EOF

" support graphically cycling through options
set wildmenu

" redraw only when necessary
set lazyredraw

" search as you type
set incsearch
set showmatch

" highlight search results
set hlsearch

" case insensitive search
set ci
set ignorecase
set smartcase

" enable the ruler
set ruler

" map ctrlp to the synonymous hotkey
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" ignore files in .gitigore
let g:ctrlp_user_command = ['.git', '.tox', 'build', 'bin', '__pycache__', 'cd %s && git ls-files -co --exclude-standard']

" use the silver searcher for grep commands
if executable('ag')
    " Note we extract the column as well as the file and line number
    set grepprg=ag\ --nogroup\ --nocolor\ --column
    set grepformat=%f:%l:%c%m
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    let g:ctrlp_use_caching = 1
endif

" run black on save for Python files
autocmd BufWritePre *.py execute ':Black'
let g:black_linelength = 79

" enable spellchecking
set spell
" set spellang=en_gb

" write undo file so that undo works even after restarting
set undofile

" configure NerdTree
let NERDTreeIgnore=['\.pyc$', '\~$'] "ignore files in NERDTree
let g:ycm_autoclose_preview_window_after_completion=1

" configure trailing whitespace
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn ctermbg=9
endif

" use right and left keys to jump through ag search matches in the quickfix
" list
nmap <silent> <RIGHT> :cnext<CR>
nmap <silent> <LEFT> :cprev<CR>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" open a quickfix window after :grep
autocmd QuickFixCmdPost *grep* cwindow

" configure ale (asynchronous linting engine)
let g:ale_completion_enabled = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" make Vim Tmux runner behavior sane for Python
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1

" Redo with U instead of Ctrl+R
nnoremap U <C-R>

" always leave some lines visible at the bottom of the buffer
set scrolloff=3

" a few sensible defaults
set encoding=utf_8
set showmode
set showcmd
set hidden
set wildmode=list:longest
set visualbell
set ttyfast
set backspace=indent,eol,start
set laststatus=2

" improve regex handling
nnoremap / /\v
vnoremap / /\v

" turn off arrow keys to force discipline on myself
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" make j and k move by file line instead of screen line
nnoremap j gj
nnoremap k gk

" disable the F1 help shortcut
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" make the semicolon also act like a colon in normal mode
nnoremap ; :

" save buffer contents on lost focus
au FocusLost * :wa

" remap leader
let mapleader = "<Space>"

" zoom a vim pane, <C-w>= to re-balance
nnoremap <leader>- :wincmd _<cr>:wincmd \|<cr>
nnoremap <leader>= :wincmd =<cr>

" strip all trailing whitespace in the curent file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" use jk to leave insert mode
inoremap jk <ESC>

" turn on soft word wrapping but disable automatic linebreaks
set wrap
set linebreak
set nolist  " list disables linebreak

" do not automatically insert linebreaks
set textwidth=0
set wrapmargin=0

