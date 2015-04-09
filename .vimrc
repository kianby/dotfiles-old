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
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-repeat'
Bundle 'majutsushi/tagbar'
Bundle 'scrooloose/syntastic'
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-obsession'
Bundle 'scrooloose/nerdtree'
Bundle "pangloss/vim-javascript"

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

if has ('gui') " On Linux use + register for copy-paste
    set clipboard=unnamedplus
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

" Syntastic
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_python_exec = '/usr/bin/python3'

" open tag bar
nmap <F8> :TagbarToggle<CR>

" JSON formatter
nmap <leader>json :%!python -m json.tool

" CTRL-P key bindings
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>

" NerdTree key binding
nnoremap <C-n> :NERDTreeToggle<CR>

" Execute current line in a shell
nmap <F5> :exec '!'.getline('.')<CR>

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

" Fix colors in tmux context
let base16colorspace=256

" Tomorrow Night Eighties - Full Colour and 256 Colour
" http://chriskempson.com
"
" Hex colour conversion functions borrowed from the theme "Desert256""

" Default GUI Colours
let s:foreground = "cccccc"
let s:background = "2d2d2d"
let s:selection = "515151"
let s:line = "393939"
let s:comment = "999999"
let s:red = "f2777a"
let s:orange = "f99157"
let s:yellow = "ffcc66"
let s:green = "99cc99"
let s:aqua = "66cccc"
let s:blue = "6699cc"
let s:purple = "cc99cc"
let s:window = "4d5057"

hi clear
syntax reset

let g:colors_name = "Tomorrow-Night-Eighties"

if has("gui_running") || &t_Co == 88 || &t_Co == 256
        " Returns an approximate grey index for the given grey level
        fun <SID>grey_number(x)
                if &t_Co == 88
                        if a:x < 23
                                return 0
                        elseif a:x < 69
                                return 1
                        elseif a:x < 103
                                return 2
                        elseif a:x < 127
                                return 3
                        elseif a:x < 150
                                return 4
                        elseif a:x < 173
                                return 5
                        elseif a:x < 196
                                return 6
                        elseif a:x < 219
                                return 7
                        elseif a:x < 243
                                return 8
                        else
                                return 9
                        endif
                else
                        if a:x < 14
                                return 0
                        else
                                let l:n = (a:x - 8) / 10
                                let l:m = (a:x - 8) % 10
                                if l:m < 5
                                        return l:n
                                else
                                        return l:n + 1
                                endif
                        endif
                endif
        endfun

        " Returns the actual grey level represented by the grey index
        fun <SID>grey_level(n)
                if &t_Co == 88
                        if a:n == 0
                                return 0
                        elseif a:n == 1
                                return 46
                        elseif a:n == 2
                                return 92
                        elseif a:n == 3
                                return 115
                        elseif a:n == 4
                                return 139
                        elseif a:n == 5
                                return 162
                        elseif a:n == 6
                                return 185
                        elseif a:n == 7
                                return 208
                        elseif a:n == 8
                                return 231
                        else
                                return 255
                        endif
                else
                        if a:n == 0
                                return 0
                        else
                                return 8 + (a:n * 10)
                        endif
                endif
        endfun

        " Returns the palette index for the given grey index
        fun <SID>grey_colour(n)
                if &t_Co == 88
                        if a:n == 0
                                return 16
                        elseif a:n == 9
                                return 79
                        else
                                return 79 + a:n
                        endif
                else
                        if a:n == 0
                                return 16
                        elseif a:n == 25
                                return 231
                        else
                                return 231 + a:n
                        endif
                endif
        endfun

        " Returns an approximate colour index for the given colour level
        fun <SID>rgb_number(x)
                if &t_Co == 88
                        if a:x < 69
                                return 0
                        elseif a:x < 172
                                return 1
                        elseif a:x < 230
                                return 2
                        else
                                return 3
                        endif
                else
                        if a:x < 75
                                return 0
                        else
                                let l:n = (a:x - 55) / 40
                                let l:m = (a:x - 55) % 40
                                if l:m < 20
                                        return l:n
                                else
                                        return l:n + 1
                                endif
                        endif
                endif
        endfun

        " Returns the actual colour level for the given colour index
        fun <SID>rgb_level(n)
                if &t_Co == 88
                        if a:n == 0
                                return 0
                        elseif a:n == 1
                                return 139
                        elseif a:n == 2
                                return 205
                        else
                                return 255
                        endif
                else
                        if a:n == 0
                                return 0
                        else
                                return 55 + (a:n * 40)
                        endif
                endif
        endfun

        " Returns the palette index for the given R/G/B colour indices
        fun <SID>rgb_colour(x, y, z)
                if &t_Co == 88
                        return 16 + (a:x * 16) + (a:y * 4) + a:z
                else
                        return 16 + (a:x * 36) + (a:y * 6) + a:z
                endif
        endfun

        " Returns the palette index to approximate the given R/G/B colour levels
        fun <SID>colour(r, g, b)
                " Get the closest grey
                let l:gx = <SID>grey_number(a:r)
                let l:gy = <SID>grey_number(a:g)
                let l:gz = <SID>grey_number(a:b)

                " Get the closest colour
                let l:x = <SID>rgb_number(a:r)
                let l:y = <SID>rgb_number(a:g)
                let l:z = <SID>rgb_number(a:b)

                if l:gx == l:gy && l:gy == l:gz
                        " There are two possibilities
                        let l:dgr = <SID>grey_level(l:gx) - a:r
                        let l:dgg = <SID>grey_level(l:gy) - a:g
                        let l:dgb = <SID>grey_level(l:gz) - a:b
                        let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
                        let l:dr = <SID>rgb_level(l:gx) - a:r
                        let l:dg = <SID>rgb_level(l:gy) - a:g
                        let l:db = <SID>rgb_level(l:gz) - a:b
                        let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
                        if l:dgrey < l:drgb
                                " Use the grey
                                return <SID>grey_colour(l:gx)
                        else
                                " Use the colour
                                return <SID>rgb_colour(l:x, l:y, l:z)
                        endif
                else
                        " Only one possibility
                        return <SID>rgb_colour(l:x, l:y, l:z)
                endif
        endfun

        " Returns the palette index to approximate the 'rrggbb' hex string
        fun <SID>rgb(rgb)
                let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
                let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
                let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

                return <SID>colour(l:r, l:g, l:b)
        endfun

        " Sets the highlighting for the given group
        fun <SID>X(group, fg, bg, attr)
                if a:fg != ""
                        exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
                endif
                if a:bg != ""
                        exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
                endif
                if a:attr != ""
                        exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
                endif
        endfun

        " Vim Highlighting
        call <SID>X("Normal", s:foreground, s:background, "")
        call <SID>X("LineNr", s:selection, "", "")
        call <SID>X("NonText", s:selection, "", "")
        call <SID>X("SpecialKey", s:selection, "", "")
        call <SID>X("Search", s:background, s:yellow, "")
        call <SID>X("TabLine", s:window, s:foreground, "reverse")
        call <SID>X("TabLineFill", s:window, s:foreground, "reverse")
        call <SID>X("StatusLine", s:window, s:yellow, "reverse")
        call <SID>X("StatusLineNC", s:window, s:foreground, "reverse")
        call <SID>X("VertSplit", s:window, s:window, "none")
        call <SID>X("Visual", "", s:selection, "")
        call <SID>X("Directory", s:blue, "", "")
        call <SID>X("ModeMsg", s:green, "", "")
        call <SID>X("MoreMsg", s:green, "", "")
        call <SID>X("Question", s:green, "", "")
        call <SID>X("WarningMsg", s:red, "", "")
        call <SID>X("MatchParen", "", s:selection, "")
        call <SID>X("Folded", s:comment, s:background, "")
        call <SID>X("FoldColumn", "", s:background, "")
        if version >= 700
                call <SID>X("CursorLine", "", s:line, "none")
                call <SID>X("CursorColumn", "", s:line, "none")
                call <SID>X("PMenu", s:foreground, s:selection, "none")
                call <SID>X("PMenuSel", s:foreground, s:selection, "reverse")
                call <SID>X("SignColumn", "", s:background, "none")
        end
        if version >= 703
                call <SID>X("ColorColumn", "", s:line, "none")
        end

        " Standard Highlighting
        call <SID>X("Comment", s:comment, "", "")
        call <SID>X("Todo", s:comment, s:background, "")
        call <SID>X("Title", s:comment, "", "")
        call <SID>X("Identifier", s:red, "", "none")
        call <SID>X("Statement", s:foreground, "", "")
        call <SID>X("Conditional", s:foreground, "", "")
        call <SID>X("Repeat", s:foreground, "", "")
        call <SID>X("Structure", s:purple, "", "")
        call <SID>X("Function", s:blue, "", "")
        call <SID>X("Constant", s:orange, "", "")
        call <SID>X("Keyword", s:orange, "", "")
        call <SID>X("String", s:green, "", "")
        call <SID>X("Special", s:foreground, "", "")
        call <SID>X("PreProc", s:purple, "", "")
        call <SID>X("Operator", s:aqua, "", "none")
        call <SID>X("Type", s:blue, "", "none")
        call <SID>X("Define", s:purple, "", "none")
        call <SID>X("Include", s:blue, "", "")
        "call <SID>X("Ignore", "666666", "", "")

        " Vim Highlighting
        call <SID>X("vimCommand", s:red, "", "none")

        " C Highlighting
        call <SID>X("cType", s:yellow, "", "")
        call <SID>X("cStorageClass", s:purple, "", "")
        call <SID>X("cConditional", s:purple, "", "")
        call <SID>X("cRepeat", s:purple, "", "")

        " PHP Highlighting
        call <SID>X("phpVarSelector", s:red, "", "")
        call <SID>X("phpKeyword", s:purple, "", "")
        call <SID>X("phpRepeat", s:purple, "", "")
        call <SID>X("phpConditional", s:purple, "", "")
        call <SID>X("phpStatement", s:purple, "", "")
        call <SID>X("phpMemberSelector", s:foreground, "", "")

        " Ruby Highlighting
        call <SID>X("rubySymbol", s:green, "", "")
        call <SID>X("rubyConstant", s:yellow, "", "")
        call <SID>X("rubyAccess", s:yellow, "", "")
        call <SID>X("rubyAttribute", s:blue, "", "")
        call <SID>X("rubyInclude", s:blue, "", "")
        call <SID>X("rubyLocalVariableOrMethod", s:orange, "", "")
        call <SID>X("rubyCurlyBlock", s:orange, "", "")
        call <SID>X("rubyStringDelimiter", s:green, "", "")
        call <SID>X("rubyInterpolationDelimiter", s:orange, "", "")
        call <SID>X("rubyConditional", s:purple, "", "")
        call <SID>X("rubyRepeat", s:purple, "", "")
        call <SID>X("rubyControl", s:purple, "", "")
        call <SID>X("rubyException", s:purple, "", "")

        " Python Highlighting
        call <SID>X("pythonInclude", s:purple, "", "")
        call <SID>X("pythonStatement", s:purple, "", "")
        call <SID>X("pythonConditional", s:purple, "", "")
        call <SID>X("pythonRepeat", s:purple, "", "")
        call <SID>X("pythonException", s:purple, "", "")
        call <SID>X("pythonFunction", s:blue, "", "")
        call <SID>X("pythonPreCondit", s:purple, "", "")
        call <SID>X("pythonRepeat", s:aqua, "", "")
        call <SID>X("pythonExClass", s:orange, "", "")

        " JavaScript Highlighting
        call <SID>X("javaScriptBraces", s:foreground, "", "")
        call <SID>X("javaScriptFunction", s:purple, "", "")
        call <SID>X("javaScriptConditional", s:purple, "", "")
        call <SID>X("javaScriptRepeat", s:purple, "", "")
        call <SID>X("javaScriptNumber", s:orange, "", "")
        call <SID>X("javaScriptMember", s:orange, "", "")
        call <SID>X("javascriptNull", s:orange, "", "")
        call <SID>X("javascriptGlobal", s:blue, "", "")
        call <SID>X("javascriptStatement", s:red, "", "")

        " CoffeeScript Highlighting
        call <SID>X("coffeeRepeat", s:purple, "", "")
        call <SID>X("coffeeConditional", s:purple, "", "")
        call <SID>X("coffeeKeyword", s:purple, "", "")
        call <SID>X("coffeeObject", s:yellow, "", "")

        " HTML Highlighting
        call <SID>X("htmlTag", s:red, "", "")
        call <SID>X("htmlTagName", s:red, "", "")
        call <SID>X("htmlArg", s:red, "", "")
        call <SID>X("htmlScriptTag", s:red, "", "")

        " Diff Highlighting
        call <SID>X("diffAdd", "", "4c4e39", "")
        call <SID>X("diffDelete", s:background, s:red, "")
        call <SID>X("diffChange", "", "2B5B77", "")
        call <SID>X("diffText", s:line, s:blue, "")

        " ShowMarks Highlighting
        call <SID>X("ShowMarksHLl", s:orange, s:background, "none")
        call <SID>X("ShowMarksHLo", s:purple, s:background, "none")
        call <SID>X("ShowMarksHLu", s:yellow, s:background, "none")
        call <SID>X("ShowMarksHLm", s:aqua, s:background, "none")

        " Lua Highlighting
        call <SID>X("luaStatement", s:purple, "", "")
        call <SID>X("luaRepeat", s:purple, "", "")
        call <SID>X("luaCondStart", s:purple, "", "")
        call <SID>X("luaCondElseif", s:purple, "", "")
        call <SID>X("luaCond", s:purple, "", "")
        call <SID>X("luaCondEnd", s:purple, "", "")

        " Cucumber Highlighting
        call <SID>X("cucumberGiven", s:blue, "", "")
        call <SID>X("cucumberGivenAnd", s:blue, "", "")

        " Go Highlighting
        call <SID>X("goDirective", s:purple, "", "")
        call <SID>X("goDeclaration", s:purple, "", "")
        call <SID>X("goStatement", s:purple, "", "")
        call <SID>X("goConditional", s:purple, "", "")
        call <SID>X("goConstants", s:orange, "", "")
        call <SID>X("goTodo", s:yellow, "", "")
        call <SID>X("goDeclType", s:blue, "", "")
        call <SID>X("goBuiltins", s:purple, "", "")

        " Clojure "highlighting
        call <SID>X("clojureConstant", s:orange, "", "")
        call <SID>X("clojureBoolean", s:orange, "", "")
        call <SID>X("clojureCharacter", s:orange, "", "")
        call <SID>X("clojureKeyword", s:green, "", "")
        call <SID>X("clojureNumber", s:orange, "", "")
        call <SID>X("clojureString", s:green, "", "")
        call <SID>X("clojureRegexp", s:green, "", "")
        call <SID>X("clojureParen", s:aqua, "", "")
        call <SID>X("clojureVariable", s:yellow, "", "")
        call <SID>X("clojureCond", s:blue, "", "")
        call <SID>X("clojureDefine", s:purple, "", "")
        call <SID>X("clojureException", s:red, "", "")
        call <SID>X("clojureFunc", s:blue, "", "")
        call <SID>X("clojureMacro", s:blue, "", "")
        call <SID>X("clojureRepeat", s:blue, "", "")
        call <SID>X("clojureSpecial", s:purple, "", "")
        call <SID>X("clojureQuote", s:blue, "", "")
        call <SID>X("clojureUnquote", s:blue, "", "")
        call <SID>X("clojureMeta", s:blue, "", "")
        call <SID>X("clojureDeref", s:blue, "", "")
        call <SID>X("clojureAnonArg", s:blue, "", "")
        call <SID>X("clojureRepeat", s:blue, "", "")
        call <SID>X("clojureDispatch", s:blue, "", "")

        " Scala "highlighting
        call <SID>X("scalaKeyword", s:purple, "", "")
        call <SID>X("scalaKeywordModifier", s:purple, "", "")
        call <SID>X("scalaOperator", s:blue, "", "")
        call <SID>X("scalaPackage", s:red, "", "")
        call <SID>X("scalaFqn", s:foreground, "", "")
        call <SID>X("scalaFqnSet", s:foreground, "", "")
        call <SID>X("scalaImport", s:purple, "", "")
        call <SID>X("scalaBoolean", s:orange, "", "")
        call <SID>X("scalaDef", s:purple, "", "")
        call <SID>X("scalaVal", s:purple, "", "")
        call <SID>X("scalaVar", s:aqua, "", "")
        call <SID>X("scalaClass", s:purple, "", "")
        call <SID>X("scalaObject", s:purple, "", "")
        call <SID>X("scalaTrait", s:purple, "", "")
        call <SID>X("scalaDefName", s:blue, "", "")
        call <SID>X("scalaValName", s:foreground, "", "")
        call <SID>X("scalaVarName", s:foreground, "", "")
        call <SID>X("scalaClassName", s:foreground, "", "")
        call <SID>X("scalaType", s:yellow, "", "")
        call <SID>X("scalaTypeSpecializer", s:yellow, "", "")
        call <SID>X("scalaAnnotation", s:orange, "", "")
        call <SID>X("scalaNumber", s:orange, "", "")
        call <SID>X("scalaDefSpecializer", s:yellow, "", "")
        call <SID>X("scalaClassSpecializer", s:yellow, "", "")
        call <SID>X("scalaBackTick", s:green, "", "")
        call <SID>X("scalaRoot", s:foreground, "", "")
        call <SID>X("scalaMethodCall", s:blue, "", "")
        call <SID>X("scalaCaseType", s:yellow, "", "")
        call <SID>X("scalaLineComment", s:comment, "", "")
        call <SID>X("scalaComment", s:comment, "", "")
        call <SID>X("scalaDocComment", s:comment, "", "")
        call <SID>X("scalaDocTags", s:comment, "", "")
        call <SID>X("scalaEmptyString", s:green, "", "")
        call <SID>X("scalaMultiLineString", s:green, "", "")
        call <SID>X("scalaUnicode", s:orange, "", "")
        call <SID>X("scalaString", s:green, "", "")
        call <SID>X("scalaStringEscape", s:green, "", "")
        call <SID>X("scalaSymbol", s:orange, "", "")
        call <SID>X("scalaChar", s:orange, "", "")
        call <SID>X("scalaXml", s:green, "", "")
        call <SID>X("scalaConstructorSpecializer", s:yellow, "", "")
        call <SID>X("scalaBackTick", s:blue, "", "")

        " Git
        call <SID>X("diffAdded", s:green, "", "")
        call <SID>X("diffRemoved", s:red, "", "")
        call <SID>X("gitcommitSummary", "", "", "bold")

        " Delete Functions
        delf <SID>X
        delf <SID>rgb
        delf <SID>colour
        delf <SID>rgb_colour
        delf <SID>rgb_level
        delf <SID>rgb_number
        delf <SID>grey_colour
        delf <SID>grey_level
        delf <SID>grey_number
endif

set background=dark

