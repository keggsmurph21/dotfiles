" General {{{

" vim:foldmethod=marker:foldlevel=0

set nocompatible

" vi can only have one version of python loaded at a time, so
" the first version that gets loaded is the only one that we
" can load.  Thus, we explicitly load python3 here...
if has('python3')
endif

syntax enable " highlighting

let mapleader = "\\" " for extra key combos

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

    Plugin 'VundleVim/Vundle.vim'
    Plugin 'cakebaker/scss-syntax.vim'
    Plugin 'leafgarland/typescript-vim'
    Plugin 'Quramy/tsuquyomi' " typescript omni-complete
    setlocal indentkeys+=0.
    Plugin 'alvan/vim-closetag'
    Plugin 'swig'
    Plugin 'neovimhaskell/haskell-vim'
    Plugin 'hashivim/vim-terraform'
    Plugin 'hashivim/vim-packer'
    Plugin 'pearofducks/ansible-vim'
    Plugin 'rhysd/vim-clang-format'
    Plugin 'xavierd/clang_complete'
    Plugin 'scrooloose/nerdtree'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'vim-airline/vim-airline'
    Plugin 'kien/ctrlp.vim'
    Plugin 'cespare/vim-toml'
    Plugin 'psf/black'
    Plugin 'elzr/vim-json'
    Plugin 'vim-latex/vim-latex'
    Plugin 'flammie/vim-conllu'
    Plugin 'lepture/vim-jinja'
    Plugin 'rust-lang/rust.vim'
    Plugin 'jaspervdj/stylish-haskell'
    Plugin 'fisadev/vim-isort'
    Plugin 'powerman/vim-plugin-AnsiEsc'
    Plugin 'ElmCast/elm-vim'
    Plugin 'udalov/kotlin-vim'

call vundle#end()

filetype plugin indent on

" Run a login shell (this ensures that ~/.bash_profile will be sourced!)
set shell=bash\ --login

" Set environment variables that will get passed on to subprocs
let $SH_ENV = 'vim'

" }}}

" Editor {{{

set history=420
set autoread " read when a file is changed from outside

set path+=**
set wildmenu
set wildmode=longest:full,full
set wildignore=*.o,*~,*.pyc,*/.git/*

set backspace=eol,start,indent
set whichwrap+=<,>,h,l

set ignorecase " when searching
set smartcase
set incsearch " behave like modern browsers
set hlsearch " highlight search results

" display <tab> as >\u00b7+ and &nbsp; as \u23b5 (<C-v>u....)
set list
set listchars=tab:>·,nbsp:⎵

set linebreak " softwrap: break intelligently
set showcmd " show current command buffer
set nojoinspaces
set mouse+=a " allow clicking!

set scrolloff=3 " show lines above & below cursor if possible

set lazyredraw " macro performance
set magic " regex

set showmatch " show matching brackets
set matchtime=2 " blink speed for bracket matching

set number
set relativenumber
set numberwidth=4

set encoding=utf8
set fileformats=unix

set nobackup
set nowritebackup
set noswapfile

set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

set autoindent
set smartindent
set nowrap

set background=dark

set hidden " allow hiding modified buffers

set foldenable
set foldlevelstart=10   " only fold after 10 levels
set foldnestmax=10      " only allow 10 levels of nest
set foldmethod=indent

set display=lastline  " show as much of wrapped last line as possible

" }}}

" Highlighting {{{

highlight SpecialKey ctermfg=darkgrey
highlight LineNr ctermfg=DarkGrey ctermbg=NONE

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%$\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" }}}

" Autocommands {{{

augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup end

" automatically open files in hex mode
augroup binaryfile
    au!
    au BufReadPre   *.bin,*.class let &bin=1
    au BufReadPost  *.bin,*.class if &bin | %!xxd
    au BufReadPost  *.bin,*.class set filetype=xxd | endif
    au BufWritePre  *.bin,*.class if &bin | %!xxd -r
    au BufWritePre  *.bin,*.class endif
    au BufWritePost *.bin,*.class if &bin | %!xxd
    au BufWritePost *.bin,*.class set nomod | endif
augroup END

au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

au FileType html setlocal shiftwidth=2
au FileType javascript setlocal shiftwidth=2
au FileType typescript setlocal shiftwidth=2
au FileType jinja.html setlocal shiftwidth=2

au FileType markdown setlocal wrap columns=120

au BufNewFile,BufRead *.ts setlocal filetype=typescript
au BufNewFile,BufRead *.tsx setlocal filetype=typescript
au BufNewFile,BufRead *.ejs setlocal filetype=html
au BufNewFile,BufRead .git-blame-ignore-revs-file setlocal filetype=conf
au BufNewFile,BufRead requirements.txt setlocal filetype=conf
au BufNewFile,BufRead .clang-format setlocal filetype=yaml
au BufNewFile,BufRead .prettierrc setlocal filetype=yaml
au BufNewFile,BufRead *.hcl setlocal filetype=terraform

" slides :^)
au BufNewFile,BufRead *.slide setlocal filetype=markdown
au BufNewFile,BufRead *.slide setlocal foldmethod=marker
au BufNewFile,BufWinEnter,BufRead *.slide setlocal foldlevel=0
au BufNewFile,BufRead *.slide setlocal nowrap
au BufNewFile,BufRead *.slide setlocal shiftwidth=2

" return to last edit position when opening files
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" }}}

" Functions, Mappings, etc. {{{

" unbind things
nmap Q <Nop>

" accidental caps
command! W w
command! Q q
command! Wq wq
command! WQ wq
command! Qw wq
command! QW wq
command! Qa qall
command! QA qall

" move vertically *visually* (i.e., thru wrapped lines)
nnoremap j gj
nnoremap k gk

" toggle fold
nnoremap <space> za

" visual-mode pressing */# searches for current selection
vnoremap <silent> * :<C-u>call VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<cr>/<C-R>=@/<cr><cr>

" move line (up|down) with Ctrl+[jk<up><down>]
"nmap <C-K> :m-2<cr>==
nnoremap <C-UP> :m-2<cr>==
"nmap <C-J> :m+<cr>==
nnoremap <C-DOWN> :m+<cr>==

" pretty-print JSON
nnoremap <leader>j :%!python -m json.tool<cr>

" enter visual block mode
nnoremap <leader>v <C-v>

" copy / paste to system clipboard
vnoremap <C-c> "+y
nnoremap <C-c> V"+y
nnoremap <C-v> "+P

" edit/source vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" save as sudo
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!

" tell vim to re-detect filetype
cnoremap #! filetype detect<cr>

" move b/w windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

" create a new buffer (list all with :ls)
nnoremap <leader>t :enew<cr>

" close current buffer and move to previous
nnoremap <leader>q :bprevious<bar>bdelete #<cr>

" close all buffers
nnoremap <leader>Q :bufdo bd<cr>

" move b/w buffers
nnoremap <C-h> :bprevious<cr>
nnoremap <C-l> :bnext<cr>

" quote word
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>`<lv`>ll
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>`<lv`>ll

" easier movement to beginning / end of line
nnoremap H ^
nnoremap L $

" clear hlsearch
nnoremap <leader><space> :nohlsearch<cr>

" highlight last inserted text
nnoremap gV `[v`]

" autoformatting XML / HTML
function! Tidy(type)
    :silent execute "!tidy -q -mi -".a:type." -wrap %" | edit! | redraw!
endfunction
cnoremap <leader>xml call Tidy("xml")
cnoremap <leader>html call Tidy("html")

" start writing a command that will be executed by an interactive bash session
cnoremap <leader><leader> !/bin/bash -i -c '

iabbrev @@ kevin@murp.us

" kill to EOL
inoremap <C-k> <esc>ld$A

" {{{ undo

" stolen from https://github.com/dankamongmen/dankhome/blob/master/.vimrc
"
" Keep undo history across sessions
" see :help undo-persistence
if exists("+undofile")
  " create dir if it doesn't exist
  if isdirectory($HOME . '/.vim/undo') == 0
    :silent !mkdir -p ~/.vim/undo > /dev/null 2>&1
  endif
  " if path ends in two slashes, file name will use complete path
  " :help dir
  set undodir=~/.vim/undo//
  set undofile
  set undolevels=500
  set undoreload=500
endif

" }}}

" }}}

" Plugins {{{

" clang_complete {{{

"autocmd FileType c,cpp,objc,typescript,javascript ClangFormatAutoEnable
let g:clang_library_path='/usr/lib/x86_64-linux-gnu/libclang-6.0.so.1'
let g:clang_auto_select=0
let g:clang_close_preview=1
let g:clang_complete_macros=1

" }}}

" vim-airline {{{

let g:airline_theme='custom'
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1

" }}}

" CtrlP {{{
" ---------------------------------------
" <c-f>/<c-b>   cycle b/w modes
" <c-d>         search filename only
" <c-r>         search regex
" <c-j>/<c-k>   navigate results list
" <c-t>         open in new tab
" <c-v>         open in vsplit
" <c-x>         open in xsplit
" <c-n>/<c-p>   cycle thru prompt history
" <c-y>         create new file & parent dirs
" <c-z>         mark/unmark file
" <c-o>         open marked files
" :<command>    execute <command> after opening (e.g. :25)
nnoremap <c-p> :CtrlP<cr>
let g:ctrlp_custom_ignore = {
    \   'dir':  '\v[\/](\.git|__pycache__|efs)$',
    \   'file': '\v\.(o|class|png|jpg|jpeg)$',
    \}
let g:ctrlp_max_files=0
let g:ctrlp_clear_cache_on_exit=0
let g:ctrlp_working_path_mode = 'r'

" Adapted from https://github.com/kien/ctrlp.vim/issues/174#issuecomment-49747252
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files --others --cached --exclude-standard']

" }}}

" black {{{

let g:black_quiet=1
let g:black_linelength=100
autocmd FileType python cnoremap <buffer> <leader>b Black<cr>

" }}}

" syntastic {{{

set statusline+=%#warningmsg
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1

let g:syntastic_cpp_compiler = 'clang'
let g:syntastic_cpp_compiler_options = '-std=c++17'

let g:syntastic_java_checkers = []
let g:syntastic_python_checkers = ['mypy', 'flake8']
let g:syntastic_typescript_checkers = ['tsuquyomi']

command! ToggleLinting SyntasticToggleMode
command! TL SyntasticToggleMode

" }}}

" tsuquyomi {{{

let g:tsuquyomi_disable_quickfix = 1

" }}}

" rust.vim {{{

let g:rustfmt_autosave = 1

" }}}

" stylish-haskell {{{

autocmd FileType haskell nnoremap <leader>f :%! stylish-haskell<cr>

" }}}

" }}}

" local config {{{

if filereadable(expand('~/.vimrc.local'))
    source ~/.vimrc.local
endif

" }}}
