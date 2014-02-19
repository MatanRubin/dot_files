" General Settings
set number
set hlsearch
set ignorecase smartcase
set nocompatible
filetype off "This line must exist before vundle configuration
set hidden
set incsearch
set noerrorbells
set novisualbell 

" ==================================
"              MOLOKAI AUTO INSTALL
" "=================================
let iCanHazMolokai=1
let molokai_file=expand('~/.vim/colors/molokai.vim')
if !filereadable(molokai_file)
    echo "Installing Molokai color theme.."
    echo ""
    silent !mkdir -p ~/.vim/colors
    silent !wget -P ~/.vim/colors https://raw.github.com/tomasr/molokai/master/colors/molokai.vim 
    let iCanHazMolokai=0
endif

" Color Scheme
if has ('gui_running')
        colorscheme molokai
	"let g:molokai_original = 1
        "syntax on
	set guifont=Monospace\ 11
else
        "colorscheme default
        colorscheme molokai
	"let g:molokai_original = 1
endif

 
" ==================================
"              VUNDLE AUTO INSTALL
" "=================================
" Setting up Vundle - the vim plugin bundler
" Based on: http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
 let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
"if has ('gui_running')
	Bundle 'gmarik/vundle'
	" Installed Bundles
	" File navigation bundles
	Bundle 'ctrlp.vim'
	Bundle 'Tagbar'
	Bundle 'The-NERD-tree'
	Bundle 'bufexplorer.zip'
	Bundle 'https://github.com/mileszs/ack.vim.git'
	" Alternate quickley between header and source files in C/C++
	Bundle 'a.vim'

	" Text input bundles
	"Bundle 'snipMate'
	Bundle 'SirVer/ultisnips'
	Bundle 'SearchComplete'
	Bundle 'Tabular'
	Bundle 'unimpaired.vim'
	Bundle 'VisIncr'
	Bundle 'Align'
	Bundle 'http://github.com/tpope/vim-surround'
	Bundle 'Raimondi/delimitMate'

	" User interface bundles
	Bundle 'https://github.com/Lokaltog/vim-powerline'
	Bundle 'https://github.com/mhinz/vim-startify.git'
	Bundle 'fontsize.vim'
	Bundle 'git://github.com/altercation/vim-colors-solarized.git'
	Bundle 'https://github.com/tpope/vim-vividchalk.git'

	" Python bundles
	Bundle 'indentpython.vim'
	Bundle 'klen/python-mode'
	Bundle 'pyflakes.vim'
	"Bundle 'pydoc.vim'
	Bundle 'pep8'
	"Bundle 'pytest.vim' - did not use it so far
	"Bundle 'https://github.com/davidhalter/jedi-vim' - annoying
	"autocomplete, removed for now.

	" Git bundles
	Bundle 'http://github.com/tpope/vim-fugitive.git'
	Bundle 'https://github.com/tpope/vim-git.git'

	" Unused bundles
	"Bundle 'taglist.vim'
	"Bundle 'AutoComplPop'
	"Bundle 'https://github.com/ervandew/supertab.git'
	"Bundle 'perl-support.vim'
	"Bundle 'https://github.com/sontek/rope-vim.git'
	Bundle 'The-NERD-Commenter'

	" General bundles
	Bundle 'Gundo'
	Bundle 'TaskList.vim'
	Bundle 'https://github.com/reinh/vim-makegreen'
	Bundle 'https://github.com/rosenfeld/conque-term'
	Bundle 'powerman/vim-plugin-viewdoc'

	" C bundles
	"Bundle 'https://github.com/scrooloose/syntastic.git'
	" YouCompleteMe needs special manual install that is LONG but well
	" explained in https://github.com/Valloric/YouCompleteMe
	" Be sure to also change the compilation flags according to your
	" project (instruction in YCM documentation
	Bundle 'Valloric/YouCompleteMe'
	
	" Improved C syntax highlighting - highlights user defined functions
	" These plugins provide nice functionality but slow down vim
	" significantly
	" Bundle 'https://github.com/xolox/vim-easytags'
	" Bundle 'https://github.com/xolox/vim-misc'
"endif

if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
endif
" ==================================
"                 PLUGINS SETTINGS
" "=================================
filetype plugin indent on "This line must exist after vundle configuration

" Verilog Module Find
"map ` ma?^\s*\<module\><CR>Wyiw'a:echo "module -->" @0<CR>
 
" BuffExplorer
map <C-b> :BufExplorer<CR>
 
" NERDTree
let NERDTreeDirArrows=1
map <C-n> :NERDTreeToggle<CR>
scriptencoding utf-8
set encoding=utf-8
 
" Tagbar settings
nnoremap <silent> <F9> :TagbarToggle<CR>

" Powerline
" To install Powerline fonts:
" 	mkdir ~/.fonts
" 	cd ~/.fonts/
" 	git clone https://github.com/scotu/ubuntu-mono-powerline.git
set laststatus=2
let g:Powerline_symbols = 'fancy'

" CtrlP
"map <C-p> :CtrlPMRU<CR>
let g:ctrlp_cmd = 'CtrlPMRU'

" Unimpaired
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv
 
" Indentation Commands
nmap <D-[> <<
nmap <D-]> >>
vmap < <gv
vmap > >gv
 
" NERD Commenter
"map <leader>cc <plug>NERDCommenterMinimal
"map <D-/> <plug>NERDCommenterToggle

" SnipMate
"nmap ,rs :call ReloadSnippets(snippets_dir, &filetype)<CR>
" To add the ReloadSnippets function, add the following to SnipMate.vim:
"function! ReloadSnippets( snippets_dir, ft )
    "if strlen( a:ft ) == 0
        "let filetype = "_"
    "else
        "let filetype = a:ft
    "endif

    "call ResetSnippets()
    "call GetSnippets( a:snippets_dir, filetype )
"endfunction

"Source the vimrc file after saving it
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" Pressing ,v opens the vimrc file in a new tab.
let mapleader = ","
nmap <leader>v :tabedit $MYVIMRC<CR>
 

" Tab completion
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"

" Ack
nmap <leader>a <Esc>:Ack!


"nmap <F3> = jedi#goto_definitions_command


" Python-mode
" Activate rope
let g:pymode_rope = 1
" Keys:
" K             Show python docs
" <Ctrl-Space>  Rope autocomplete
" <Ctrl-c>g     Rope goto definition
" <Ctrl-c>d     Rope show documentation
" <Ctrl-c>f     Rope find occurrences
" <Leader>b     Set, unset breakpoint (g:pymode_breakpoint enabled)
" [[            Jump on previous class or function (normal, visual, operator modes)
" ]]            Jump on next class or function (normal, visual, operator modes)
" [M            Jump on previous class or method (normal, visual, operator modes)
" ]M            Jump on next class or method (normal, visual, operator modes)

" Documentation
let g:pymode_doc = 1
let g:pymode_doc_key = 'K'

"Linting
let g:pymode_lint = 1"let g:vim_debug_disable_mappings = 1
let g:pymode_rope_rename_bind = '<C-c>rr'

"Use Ctrl+Return to rotate between windows
nnoremap <C-> <C-w><C-w> 

"Use Ctrl+Shift+Return to rotate between windows in reverse order
nnoremap <C-S-> <C-w>W

" New vertical split: ,s
map <leader>s <C-w><C-v>

" New horizontal split: ,S
map <leader>S <C-w><C-s>

" Close split: ,q
"map <leader>q <C-w><C-q>

" increase/decrease split window size
map <C-w>> :30winc ><CR>
map <C-w>< :30winc <<CR>

" Rotate buffers in current window
nnoremap <C-Tab> :bn<CR>

" Rotate tabs
nnoremap <C-\> :tabNext<CR>

" Change current directory to the directory of the file in buffer
"nmap
let g:pymode_lint_checker = "pyflakes,pep8"
" Auto check on save
let g:pymode_lint_write = 1

" Support virtualenv
let g:pymode_virtualenv = 1

" Enable breakpoints plugin
"let g:pymode_breakpoint = 1
"let g:pymode_breakpoint_key = '<leader>b'

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

" Don't autofold code
let g:pymode_folding = 0

" Jedi-vim
"let  g:jedi#use_tabs_not_buffers = 0
"let g:jedi#completions_enable = 0

" Vim Python Debugger
"map <S-F5> :Dbg .<CR>
"map <F10> :Dbg over<CR>
"map <F11> :Dbg into<CR>
"map <S-F11> :Dbg out<CR>
"map <F2> :Dbg break<CR>
"map <F3> :Dbg here<CR>
"map <F5> :Dbg run<CR>
"map <F12> :Dbg quit<CR>
"map <S-F12> :Dbg quit <CR>:Dbg .<CR>
"let g:vim_debug_disable_mappings = 1

"Better window navigation
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-h> <C-w>h
"nnoremap <C-l> <C-w>l

"Use Ctrl+Return to rotate between windows
nnoremap <C-> <C-w><C-w> 

"Use Ctrl+Shift+Return to rotate between windows in reverse order
nnoremap <C-S-> <C-w>W

" New vertical split: ,s
map <leader>s <C-w><C-v>

" New horizontal split: ,S
map <leader>S <C-w><C-s>

" Close split: ,q
map <leader>q <C-w><C-q>

" increase/decrease split window size
map <C-w>> :30winc ><CR>
map <C-w>< :30winc <<CR>

" Rotate buffers in current window
nnoremap <C-Tab> :bn<CR>

" Rotate tabs
nnoremap <C-\> :tabNext<CR>

" Change current directory to the directory of the file in buffer
"nmap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" YouCompleteMe
let g:ycm_confirm_extra_conf = 0
let g:ycm_global_ycm_extra_conf = '~/dot_files/ycm_extra_conf.py'
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<Up>']

nnoremap <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Complete UltiSnip snippets with <tab>
function! g:UltiSnips_Complete()
    call UltiSnips_ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips_JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"

" User defined Snippets
let g:UltiSnipsSnippetsDir="~/dot_files/ultisnips/"

" Stop YCM completion with enter, in addition to default ctrl+y
imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

" Color Column
set colorcolumn=80

" Auto close brackets
"inoremap {      {}<Left>
"inoremap {<CR>  {<CR>}<Esc>O
"inoremap {{     {
"inoremap {}     {}
"inoremap        (  ()<Left>
"inoremap <expr> (  strpart(getline('.'), col('.'), 1) == "(" ? ");\<Left>\<Left>" : "()\<Left>"
"inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
"inoremap <expr> ;  strpart(getline('.'), col('.')-1, 1) == ";" ? "\<Right>" : ";"

" Put semicolon at the end of line (except when in "for")
inoremap <expr> ;  matchstr(getline('.'), "for") == "for" ? ";" : "\<End>;"

" Switch 9 and (
"inoremap 9 ()<Left>
"inoremap ( 9

" Delete () together
"inoremap <expr> <BS> strpart(getline('.'), col('.')-2, 2) == "()" ? "\<Right><BS><BS>" : "<BS>"


" DelimitMate
"au FileType c,perl let b:delimitMate_eol_marker = ";"
let delimitMate_expand_cr = 1

" Spelling
iab NYLL NULL
iab retrun return

" Commenting

" x and xx perform "cut", d and dd perform "delete"
noremap x d
noremap xx dd
noremap d "_d
noremap dd "_dd
