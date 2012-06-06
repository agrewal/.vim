set nocompatible              " Don't be compatible with vi
let mapleader=","             " change the leader to be a comma vs slash

" sudo write this
cmap W! w !sudo tee % >/dev/null

command! -nargs=1 Silent
\ | execute ':silent '.<q-args>
\ | execute ':redraw!'

function! MyMake() 
    silent make 
    redraw! 
    for i in getqflist() 
        if i['valid'] 
            cwin 
            cc
            return 
        endif 
    endfor 
    cclose
    echo "Make complete !"
endfunction 

" ,v brings up my .vimrc
" ,V reloads it -- making all changes active (have to save first)
map <leader>v :sp ~/.vimrc<CR><C-W>_
map <silent> <leader>V :source ~/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

" quit window on <leader>q
nnoremap <leader>q :q<cr>

" open/close the quickfix window
nmap <leader>co :copen<CR>
nmap <leader>cc :cclose<CR>

" Ack searching
nmap <leader>a <Esc>:Ack!

" Load the Gundo window
map <leader>g :GundoToggle<CR>

" Make 
map <silent> <Leader>m :call MyMake()<cr>

" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

" Paste from clipboard
map <leader>p "+gP

" CommandT mapping
nmap <silent> <Leader>f :CommandT<CR>

" Delete buffer
nmap <C-k> :bdelete<CR>

"" SFE mappings
"let g:sfe_mapLeader = ',s'
"let g:sfe_mapLeaderAlternate = ',S'
"let g:sfe_mapKeyCommitTracked = 'c'
"let g:sfe_mapKeyCommitAll     = 'a'

"ShowMarks mappings
set updatetime=100
let g:showmarks_ignore_type="hmpq"
let g:showmarks_textlower="\t"
let g:showmarks_textupper="\t"
let g:showmarks_textother="\t"
let g:showmarks_hlline_lower=0
let g:showmarks_hlline_upper=0
let g:showmarks_hlline_other=0
map <silent> <unique> ;mt :ShowMarksToggle<cr>
map <silent> <unique> ;mo :ShowMarksOn<cr>
map <silent> <unique> ;mh :ShowMarksClearMark<cr>
map <silent> <unique> ;ma :ShowMarksClearAll<cr>
map <silent> <unique> ;mm :ShowMarksPlaceMark<cr>

" NERDTree mappings
map <F1> :NERDTreeToggle<CR>
imap <F1> <ESC>:NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeChDirMode=2

" TagBar mappings
nnoremap <silent> <F2> :TagbarToggle<CR>
inoremap <silent> <F2> <ESC>:TagbarToggle<CR>
let g:tagbar_type_scala = {
    \ 'ctagstype' : 'Scala',
    \ 'kinds'     : [
        \ 'p:packages:1',
        \ 'V:values',
        \ 'v:variables',
        \ 'T:types',
        \ 't:traits',
        \ 'o:objects',
        \ 'a:aclasses',
        \ 'c:classes',
        \ 'r:cclasses',
        \ 'm:methods'
    \ ]
\ }


"" FuzzyFinder plugin
"map <F2> :FufBuffer<CR>
"imap <F2> <ESC>:FufBuffer<CR>
"map <F3> :FufFile<CR>
"imap <F3> <ESC>:FufFile<CR>

" ==========================================================
" Pathogen - Allows us to organize our vim plugins
" ==========================================================
" Load pathogen with docs for all plugins
filetype off
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" ==========================================================
" Basic Settings
" ==========================================================
syntax on                     " syntax highlighing
filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=longest:full     " <Tab> cycles between all matching choices.

" don't bell or blink
set noerrorbells
set vb t_vb=

" Ignore these files when completing
set wildignore+=*.o,*.obj,.git,*.pyc
set grepprg=ack-grep          " replace the default grep program with ack

" Disable the colorcolumn when switching modes.  Make sure this is the
" first autocmd for the filetype here
autocmd FileType * setlocal colorcolumn=0

""" Insert completion
" don't select first item, follow typing in autocomplete
set completeopt=menuone,longest,preview
"set pumheight=6             " Keep a small completion window

""" Moving Around/Editing
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces 
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default
set hidden

" don't outdent hashes
inoremap # #

" close preview window automatically when we move around
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

"""" Reading/Writing
set noautowrite             " Never write a file unless I request it.
set noautowriteall          " NEVER.
set noautoread              " Don't automatically re-read changed files.
set modeline                " Allow vim options to be embedded in files;
set modelines=5             " they must be within the first or last 5 lines.
set ffs=unix,dos,mac        " Try recognizing dos, unix, and mac line endings.

"""" Messages, Info, Status
set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.
"set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ %{g:sfe_getStatus()}%=\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P
set statusline=%<%F%h%m%r%h%w%y\ %{&ff}\ %{\"[\".(&fenc==\"\"?&enc:&fenc).((exists(\"+bomb\")\ &&\ &bomb)?\",B\":\"\").\"]\ \"}\ lin:%l\,%L\ col:%c%V\ pos:%o\ ascii:%b\ %P

" displays tabs with :set list & displays when a line runs off-screen
set listchars=tab:>-,eol:$,trail:-,precedes:<,extends:>
"set list

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently 
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

"""" Display
if has("gui_running")
    set gfn=Menlo\ Regular:h12
    set fuopt=maxvert,maxhorz
    set background=light
    colorscheme solarized
else
    set background=dark
    colorscheme inkpot
endif

" Command-T 
let g:CommandTMaxHeight=10

" Python
"au BufRead *.py compiler nose
au FileType python set omnifunc=pythoncomplete#Complete
au FileType python setlocal expandtab shiftwidth=4 tabstop=8 softtabstop=4 smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class,with
au BufRead *.py set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
" Don't let pyflakes use the quickfix window
"let g:pyflakes_use_quickfix = 0

" Add the virtualenv's site-packages to vim path
py << EOF
import os.path
import sys
import vim
if 'VIRTUALENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    sys.path.insert(0, project_base_dir)
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF

" ============
" Go
" ============
au FileType go set makeprg=gb
au FileType go set efm=%D(in\ %f)%.%#,%f:%l:%m,%-G%.%#

" Ragel
au BufRead *.rl set ft=ragel
