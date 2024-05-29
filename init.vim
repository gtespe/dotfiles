" Lion's personal vimrc. More advanced settings are stored in files in the
" settings subfolder. Every .vim file in there will be automatically sourced.
"
" REQUIREMENTS: Symlink this file to ~/.vimrc and its parent folder to ~/.vim
" Necessary so everything can be found and no absolute paths are necessary.


" Use vim settings instead of vi settings. MUST be the first thing in the
" vimrc.
"
set nocompatible

"bootstrap plugins
 if empty(glob('~/.vim/autoload/plug.vim'))
  silent !sh -c 'mkdir -p ~/.vim/autoload/'
  silent !sh -c '
    \ curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source .vimrc
  silent !sh -c 'touch -f ~/.vim/autoload/plug.vim'
endif

call plug#begin()
  Plug 'preservim/nerdtree'
  Plug 'kien/ctrlp.vim'
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'ervandew/supertab'
  Plug 'ap/vim-css-color'
  Plug 'dense-analysis/ale'
call plug#end()

" =============================================================================
" ========== General configuration
set t_Co=256                    " Enable 256 color in vim.
set laststatus=2                " Always show the statusline.
set encoding=utf-8              " Usually necessary to show unicode glyphs.
set hidden                      " Enable hidden buffers. Basically enables

set splitbelow " split window vertically
                                " buffer switching without saving first.
syntax on                       " Enable syntax highlighting.
set updatetime=1000             " Update time of many VIM things. Seems a
                                " reasonable value.

"These are super slow even on a very fast machine.
"set cursorline                  " show the cursor line
"set cursorcolumn                " show the cursor column

set magic                       " Does some magic ;-) Newline characters, ...
"set spell                       " Spell checking is on by default.
set number                      " Enable line numbering
set ttyfast                     " The current terminal is a fast terminal so
                                " more stuff can be sent at once.
                                "
set scrolloff=10                 " Keep 5 lines visible above/below cursor.
set lazyredraw                  " More aggressive lazy redrawing. Does not appear to have an effect...


set undofile                    " Save undo's after file closes
set undodir=$HOME/.vim/undo     " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo

" Unix like tab completion.
set wildmenu
set wildmode=longest,list

" Mouse support for 'all'. Another very nice feature of this is that text
" selection with the mouse now does no more select the line numbers.
" Needs a terminal with X mouse support. One possibility for OSX is iTerm.
" Most Linux terminals are fine anyway.
"set mouse=a


" Autodetect filetype and necessary for some other stuff to work.
filetype plugin on
filetype on

"For plugin stuff
" execute pathogen#infect()


" =============================================================================
" ==========  Searching
" Fix vim regex handling.
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive if upper case in search string
set gdefault                    " Always apply substitutions globally. No more
                                " /g at the end
" The next three work together to highlight searches.
set incsearch
set showmatch
set hlsearch


" =============================================================================
" ==========  Tabs and indentation
" Always use 4 spaces as tabs.
filetype plugin indent on
filetype indent on
set tabstop=4
set shiftwidth=4            " numbers of spaces to (auto)indent
set expandtab
set smartindent             " smart autoindenting when starting a new line
set cindent                 " cindent
set autoindent  

" ====================================
" Leader
" =============================

let mapleader = "\<Space>"
nnoremap <Leader>w :w<CR>
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>h :noh<CR>

"For visual mode copy paste between vim instances
vmap <leader>y :w! /tmp/vitmp<CR>                                                                  
nmap <leader>p :r! cat /tmp/vitmp<CR>

"Move between tabs with ctrl + l/h
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>
"Toggle nerdtree with <space>n
nnoremap <Leader>n :NERDTreeToggle<CR>


"show nerdtree on startup
"autocmd vimenter * NERDTree
"Kill vim if nerdtree is the only window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""Syntax Checking
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_auto_jump=0
"let g:syntastic_check_on_open = 1
"let g:syntastic_enable_signs=1
"let g:syntastic_check_on_wq = 0
"let g:syntastic_quiet_messages = {'level': 'warnings'}
"
"let g:syntastic_c_checkers = ['clang_check']
"let g:syntastic_cpp_checkers = ['verapp', 'gcc']
"let g:syntastic_python_checkers = ['pyflakes']

" ycm configuration
"let g:ycm_show_diagnostics_ui = 0

" I like the default colorscheme...
colorscheme default
highlight search guibg=Magenta guifg=Black
highlight search ctermbg=Magenta ctermfg=Black

