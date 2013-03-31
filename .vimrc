" 
" My configuration 
"

" This must be first, because it changes other options as side effect
set nocompatible

" Vundle configuration
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle required!
Bundle 'gmarik/vundle'

" My Bundles here:
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-markdown'
Bundle 'godlygeek/tabular'
Bundle 'altercation/vim-colors-solarized'
Bundle 'majutsushi/tagbar'
Bundle 'msanders/snipmate.vim'
Bundle 'ervandew/supertab'
Bundle 'sontek/minibufexpl.vim'
Bundle 'kevinw/pyflakes-vim'
Bundle 'vim-scripts/pep8'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'sontek/rope-vim'
Bundle 'fs111/pydoc.vim'

filetype on
filetype plugin indent on     " required!
 "
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" no beep
set visualbell
set noerrorbells

" syntax highlighting
syntax on
scriptencoding utf-8

" automatically enable mouse usage
set mouse=a
set mousehide

if has ('x') && has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
elseif has ('gui') " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
endif

" better unix / windows compatibility
set viewoptions=options,cursor,unix,slash

" allow for cursor beyond last character
set virtualedit=onemore

" set backups and undos
set backup
set undofile
set undolevels=1000
set undoreload=10000
set backupdir=~/.backup,.,/tmp
set undodir=~/.backup,.,/tmp
set directory=~/.backup,.,/tmp

" load a color scheme
let g:solarized_termcolors=16
color solarized
set background=dark

" display the current mode
set showmode

" highlight current line 
set cursorline

" show partial commands in status line and selected chars/lines in visual mode
set showcmd

" backspace for dummies
set backspace=indent,eol,start

" no extra spaces between rows
set linespace=0

" enable line numbering
set nu

" show matching backets/parenthesis
set showmatch

" search
set incsearch
set hlsearch
set ignorecase
set smartcase
set gdefault 
set scrolloff=3
set scrolljump=5

" highlight problematic whitespace
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" formatting
set nowrap
set autoindent
set shiftwidth=4
set expandtab
set tabstop=8
set softtabstop=4
set textwidth=79

set pastetoggle=<F12>

" windows management
set winheight=30
set winminheight=1
nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>


" key (re)mappings
let mapleader = ','

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

"clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" force yourself to stop using the arrow keys 
"map <up> <nop>
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>

" use Q for formatting the current parapgraph (or selection)
vmap Q gq
nmap Q gqap

nnoremap <silent> <F10> :YRShow<CR>

" miniBufExplorer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" open tag bar
nmap <F8> :TagbarToggle<CR>

" open task list
map <leader>td <Plug>TaskList

" check python
let g:pyflakes_use_quickfix = 0
let g:pep8_map='<leader>8'

" tab completion and documentation
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

map <leader>j :RopeGotoDefinition<CR>
map <leader>r :RopeRename<CR>

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF