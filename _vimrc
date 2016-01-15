" first the disabled features due to security concerns
set modelines=0         " no modelines [http://www.guninski.com/vim1.html]
let mapleader=','

" Initial settings
nmap <Leader>w :w<cr>
inoremap jk <ESC>

" ---------------------------------------------------------------------------
" operational settings
set lines=30
set columns=150
set nocompatible                " vim defaults, not vi!
syntax on                       " syntax on
set hidden                      " allow editing multiple unsaved buffers
set more                        " the 'more' prompt
filetype on                     " automatic file type detection
set autoread                    " watch for file changes by other programs
set visualbell                  " visual beep
set nobackup                      " produce *~ backup files
set laststatus=2                "ls:    makes the status bar always visible
set noautowrite                 " don't automatically write on :next, etc
let maplocalleader=','          " all my macros start with ,
set wildmenu                    " : menu has tab completion, etc
set showmode                    "smd:   shows current vi mode in lower left
set showcmd                     "sc:    shows typed commands
set so=0
set ttyfast                     "tf:    improves redrawing for newer computers
set history=200                 " remember the last 200 commands

" ---------------------------------------------------------------------------
" meta
map <Leader>ce :edit ~/_vimrc<cr>          " quickly edit this file
map <Leader>cs :source ~/_vimrc<cr>        " quickly source this file

" ---------------------------------------------------------------------------
" Folding
map <F6> zfa}

" ---------------------------------------------------------------------------
" window spacing
set cmdheight=2                 " make command line two lines high
set ruler                       " show the line number on bar
set lazyredraw                  " don't redraw when running macros

map <F3> <C-W><C-W>
imap <F4> <C-x><C-o>

" ---------------------------------------------------------------------------
" window spacing
map <Leader>fw :FixWhitespace<cr>

" ---------------------------------------------------------------------------
" mouse settings
set mouse=                      " disable mouse support in all modes
set mousehide                   " hide the mouse when typing text

" ,p and shift-insert will paste the X buffer, even on the command line
nmap <Leader>p i<S-MiddleMouse><ESC>
imap <S-Insert> <S-MiddleMouse>
cmap <S-Insert> <S-MiddleMouse>

" this makes the mouse paste a block of text without formatting it
" (good for code)
map <MouseMiddle> <esc>"*p

" ---------------------------------------------------------------------------
" global editing settings
set autoindent smartindent      " turn on auto/smart indenting
set expandtab                   " use spaces, not tabs
set smarttab                    " make <tab> and <backspace> smarter
set tabstop=4                   " tabstops of 8
set shiftwidth=4                " indents of 8
set backspace=eol,start,indent  " allow backspacing over indent, eol, & start
set undolevels=1000             " number of forgivable mistakes
set updatecount=100             " write swap file to disk every 100 chars
set complete=.,w,b,u,U,t,i,d    " do lots of scanning on tab completion
set viminfo=%100,'100,/100,h,\"500,:100,n~/.viminfo

filetype plugin indent on
set ofu=syntaxcomplete#Complete

autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType do set omnifunc=phpcomplete#CompletePHP
autocmd FileType ajax set omnifunc=phpcomplete#CompletePHP
autocmd FileType post set omnifunc=phpcomplete#CompletePHP
autocmd FileType class set omnifunc=phpcomplete#CompletePHP
autocmd FileType inc set omnifunc=phpcomplete#CompletePHP
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType aspx set omnifunc=htmlcomplete#CompleteTags
autocmd FileType ascx set omnifunc=htmlcomplete#CompleteTags
autocmd FileType xml set omnifunc=omnifunc=xmlcomplete#CompleteTags
autocmd FileType css set omnifunc=omnifunc=csscomplete#CompleteCSS
autocmd FileType javascript  set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType js  set omnifunc=javascriptcomplete#CompleteJS

" Commenting
" ---------------------------------------------------------------------------
" Commenting blocks of code.
autocmd FileType c,cpp,java,scala, cs let b:comment_leader = '// '
autocmd FileType sh,ruby,python       let b:comment_leader = '# '
autocmd FileType conf,fstab           let b:comment_leader = '# '
autocmd FileType tex                  let b:comment_leader = '% '
autocmd FileType mail                 let b:comment_leader = '> '
autocmd FileType vim                  let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" ---------------------------------------------------------------------------
" searching...
set hlsearch                   " enable search highlight globally
set incsearch                  " show matches as soon as possible
set showmatch                  " show matching brackets when typing

" disable last one highlight
nmap <Leader>nh :nohlsearch<cr>

set diffopt=filler,iwhite       " ignore all whitespace and sync

" ---------------------------------------------------------------------------
" spelling...
if v:version >= 700
  let b:lastspelllang='en'
  function! ToggleSpell()
    if &spell == 1
      let b:lastspelllang=&spelllang
      setlocal spell!
    elseif b:lastspelllang
      setlocal spell spelllang=b:lastspelllang
    else
      setlocal spell spelllang=en
    endif
  endfunction

  nmap <Leader>ss :call ToggleSpell()<CR>

  setlocal spell spelllang=en
  setlocal nospell
endif

" ---------------------------------------------------------------------------
"  BufferGator
let g:buffergator_viewport_split_policy="B"
let g:buffergator_autodismiss_on_select=0
let g:buffergator_split_size=10
" ---------------------------------------------------------------------------
" ---------------------------------------------------------------------------
" Emmet Html/Css
let g:user_emmet_install_global = 0
autocmd FileType html,shtml,css,php,aspx,ascx EmmetInstall
nmap <Leader>, <C-y>,
imap <Leader>, <C-y>,
" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
" change directory to that of current file
nmap <Leader>cd :cd%:p:h<cr>
" change local directory to that of current file
nmap <Leader>lcd :lcd%:p:h<cr>

" this is for the find function plugin
nmap <Leader>ff :let name = FunctionName()<CR> :echo name<CR>

" ---------------------------------------------------------------------------
"  buffer management, note 'set hidden' above

" Move to next buffer
map <Leader>bn :bn<cr>
" Move to previous buffer
map <Leader>bp :bp<cr>
" List open buffers
map <Leader>bb :ls<cr>

" ---------------------------------------------------------------------------
" dealing with merge conflicts

" ---------------------------------------------------------------------------
function! OnlineDoc()        
        let s:browser = "\"C:/Program Files (x86)/Google/Chrome/Application/chrome.exe\""
        let s:wordUnderCursor = expand("<cword>")

        let s:url = "http://www.google.com/search?q=".s:wordUnderCursor
        let s:cmd = "silent !" . s:browser . " " . s:url
        execute  s:cmd
        redraw!
        "echo s:cmd
endfunction

" online doc search
map <Leader>k :call OnlineDoc()<CR>

" ---------------------------------------------------------------------------
" setup for the visual environment
if has('gui_running')
        set bg=light
        set guioptions-=T
        set guioptions-=m
        set guioptions+=c
        set guifont=Consolas:h11:cANSI
else
        set bg=dark
endif

set t_Co=256
set term=win32

"colorscheme monokai
"colorscheme codeschool 
colorscheme atom-dark

highlight StatusLine ctermfg=11 ctermbg=12 cterm=none guifg=#ffff00 guibg=#0000ff gui=none

" ---------------------------------------------------------------------------
" tabs
map <Leader>tc :tabnew %<cr>    " create a new tab
map <Leader>td :tabclose<cr>    " close a tab
map <Leader>tn :tabnext<cr>     " next tab
map <Leader>tp :tabprev<cr>     " previous tab
map <Leader>tm :tabmove         " move a tab to a new location

" ---------------------------------------------------------------------------
" auto load extensions for different file types
if has('autocmd')
        filetype plugin indent on
        syntax on
        autocmd BufReadPost *
                \ if line("'\"") > 0|
                \       if line("'\"") <= line("$")|
                \               exe("norm '\"")|
                \       else|
                \               exe "norm $"|
                \       endif|
                \ endif

        " improve legibility
        au BufRead quickfix setlocal nobuflisted wrap number

        " configure various extenssions
        let git_diff_spawn_mode=2

        " improved formatting for markdown
        " http://plasticboy.com/markdown-vim-mode/
        autocmd BufRead *.mkd  set ai formatoptions=tcroqn2 comments=n:>
        autocmd BufRead ~/.blog/entries/*  set ai formatoptions=tcroqn2 comments=n:>
endif

" Tags & Dictionary
set tags=./tags,tags,../tags,../../tags,../../../tags,../../../../tags,/lib/modules/$kernel_version/build/tags,/usr/include/tags,/esilo/tags
set dictionary=/usr/share/dict/words            " used with CTRL-X CTRL-K
function! DelTagOfFile(file)
  let fullpath = a:file
  let cwd = getcwd()
  let tagfilename = cwd . "/tags"
  let f = substitute(fullpath, cwd . "/", "", "")
  let f = escape(f, './')
  let cmd = 'sed -i "/' . f . '/d" "' . tagfilename . '"'
  let resp = system(cmd)
endfunction

function! UpdateTags()
  let f = expand("%:p")
  let cwd = "c:\\users\\matthew.ebersbach" 
  "let cwd = getcwd()
  let tagfilename = cwd . "\\tags"
  let cmd = 'ctags -a -f ' . tagfilename . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  "call DelTagOfFile(f)
  let resp = system(cmd)
endfunction
"autocmd BufWritePost *.cpp,*.h,*.c,*.js,*.css,*.html call UpdateTags()
" ---------------------------------------------------------------------------

" ---------------------------------------------------------------------------
"configure other scripts
map <F2> :NERDTree<CR>
map <F3> :NERDTreeClose<CR>
map <F4> :buffers<CR>

set number
set nowrap

lcd c:\users\matthew.ebersbach\

let g:NERDTreeWinSize=50

"Notes settings
:let g:notes_directories = ['~/Documents/Notes']

"Super tab settings - uncomment the next 4 lines
let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1

let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ca'

let g:OmniSharp_timeout = 1
set completeopt=longest,menuone,preview
set splitbelow

"let g:tagbar_type_javascript = {
"            \ 'ctagsbin' : 'node jsctags'
"            \ }

augroup omnisharp_commands
    autocmd!

    "Set autocomplete function to OmniSharp (if not using YouCompleteMe completion plugin)
    autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

    " Synchronous build (blocks Vim)
    "autocmd FileType cs nnoremap <F5> :wa!<cr>:OmniSharpBuild<cr>
    " Builds can also run asynchronously with vim-dispatch installed
    autocmd FileType cs nnoremap <Leader>b :wa!<cr>:OmniSharpBuildAsync<cr>
    " automatic syntax check on events (TextChanged requires Vim 7.4)
    " autocmd BufEnter,TextChanged,InsertLeave *.cs SyntasticCheck

    " Automatically add new cs files to the nearest project on save
    autocmd BufWritePost *.cs call OmniSharp#AddToProject()

    "show type information automatically when the cursor stops moving
    autocmd CursorHold *.cs call OmniSharp#TypeLookupWithoutDocumentation()

    "The following commands are contextual, based on the current cursor position.

    autocmd FileType cs nnoremap gd :OmniSharpGotoDefinition<cr>
    autocmd FileType cs nnoremap <Leader>fi :OmniSharpFindImplementations<cr>
    autocmd FileType cs nnoremap <Leader>ft :OmniSharpFindType<cr>
    autocmd FileType cs nnoremap <Leader>fs :OmniSharpFindSymbol<cr>
    autocmd FileType cs nnoremap <Leader>fu :OmniSharpFindUsages<cr>
    "finds members in the current buffer
    autocmd FileType cs nnoremap <Leader>fm :OmniSharpFindMembers<cr>
    " cursor can be anywhere on the line containing an issue
    autocmd FileType cs nnoremap <Leader>x  :OmniSharpFixIssue<cr>
    autocmd FileType cs nnoremap <Leader>fx :OmniSharpFixUsings<cr>
    autocmd FileType cs nnoremap <Leader>tt :OmniSharpTypeLookup<cr>
    autocmd FileType cs nnoremap <Leader>dc :OmniSharpDocumentation<cr>
    "navigate up by method/property/field
    autocmd FileType cs nnoremap <C-K> :OmniSharpNavigateUp<cr>
    "navigate down by method/property/field
    autocmd FileType cs nnoremap <C-J> :OmniSharpNavigateDown<cr>

augroup END

set updatetime=500

" rename with dialog
nnoremap <Leader>nm :OmniSharpRename<cr>
nnoremap <F5> :OmniSharpRename<cr>
" rename without dialog - with cursor on the symbol to rename... ':Rename newname'
command! -nargs=1 Rename :call OmniSharp#RenameTo("<args>")

" Force OmniSharp to reload the solution. Useful when switching branches etc.
nnoremap <Leader>rl :OmniSharpReloadSolution<cr>
nnoremap <Leader>cf :OmniSharpCodeFormat<cr>
" Load the current .cs file to the nearest project
nnoremap <Leader>tp :OmniSharpAddToProject<cr>

" Add syntax highlighting for types and interfaces
nnoremap <Leader>th :OmniSharpHighlightTypes<cr>

function! GotoPrj(project)
    let a:base = "lcd c:\\Source\\Microsoft .Net\\Systems\\"

    if (a:project == 'adminportal')
        silent execute a:base . "Admin Portal\\User Interfaces"
    elseif (a:project == 'advertiserportal')
        silent execute a:base . "Advertiser Portal\\User Interfaces"
    elseif (a:project == 'wcfservices')
        silent execute a:base . "Bankrate\\Services\\WCF Services"
    elseif (a:project == 'cpclib')
        silent execute a:base . "Bankrate.CPC.System\\Bankrate.CPCLib"
    elseif (a:project == 'research')
        silent execute a:base . "Research\\User Interfaces"
    elseif (a:project == 'bankrate')
        silent execute a:base . "Bankrate"
    endif
endfunction

function! RebuildTags()
    let s:currentFile = shellescape(expand('%:p'))
    let s:tagFile = shellescape(expand('%:p:h') . '\tags')
    execute '!c:\\CTags\\ctags.exe -a --options=c:\\CTags\\options.conf -f ' . s:tagFile . ' ' . s:currentFile 
    "echo '!ctags -a --options=c:\\CTags\\options.conf -f ' . s:tagFile . ' ' . s:currentFile 
endfunction
autocmd BufWritePost *.cpp,*.h,*.c,*.js,*.css,*.html call UpdateTags()
