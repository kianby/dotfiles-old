" 
" My configuration 
"

" This must be first, because it changes other options as side effect
set nocompatible
filetype off

" vim-plug configuration
call plug#begin('~/.local/share/nvim/plugged')

" My plugins here:
Plug 'scrooloose/syntastic'
Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-vinegar'
Plug 'flazz/vim-colorschemes'

call plug#end()

" no beep
set visualbell
set noerrorbells

" syntax highlighting
syntax on
scriptencoding utf-8

" automatically enable mouse usage
set mouse=a
set mousehide

if has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
endif

" better unix / windows compatibility
set viewoptions=options,cursor,unix,slash

" allow for cursor beyond last character
set virtualedit=onemore

" display the current mode
set showmode


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
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=4
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 textwidth=79

set pastetoggle=<F12>

" windows management
set winheight=30
"set winminheight=1
"nnoremap <silent> + :exe "resize " . (winheight(0) * 3/2)<CR>
"nnoremap <silent> - :exe "resize " . (winheight(0) * 2/3)<CR>


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

" Syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_python_exec = '/usr/bin/python3'

" CtrlP key settings
nnoremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|bower_components$\|dist$\|node_modules$\|project_files$\|target$\|bin$',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

" Add the virtualenv's site-packages to vim path
if  has('python')
  :py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
endif

colorscheme wombat256i

" highlight current line 
set cursorline
hi CursorLine cterm=NONE ctermbg=yellow ctermfg=black

