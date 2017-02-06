"General Settings
set shell=bash
if has("win32") || has("win64") || has("win16")
	if &shell=~#'bash$'
		set shell=$COMSPEC
	endif
endif
let $PATH = '/usr/bin:'.$PATH
set number
set hlsearch
set ignorecase smartcase
set nocompatible
set hidden
set incsearch
set noerrorbells
set novisualbell
let mapleader = ","
set nobackup       "no backup files
set nowritebackup  "only in case you don't want a backup file while editing
set noswapfile     "no swap files
set backspace=indent,eol,start " backspace over indentation, newlines
set clipboard=unnamed " copy to system clipboard

" ==================================
"              MOLOKAI AUTO INSTALL
" =================================
let iCanHazMolokai=1
let molokai_file=expand('~/.vim/colors/molokai.vim')
"let molokai_file=expand('C:\Users\rubinm3\.vim\colors\molokai.vim')
if !filereadable(molokai_file)
    echo "Installing Molokai color theme."
    silent !mkdir -p ~/.vim/colors
    silent !wget -P ~/.vim/colors https://raw.github.com/tomasr/molokai/master/colors/molokai.vim
    let iCanHazMolokai=0
endif

" Color Scheme
colorscheme molokai
let g:molokai_original = 1
syntax on

if has ('gui_macvim')
	set guifont=Meslo\ LG\ M\ Regular\ for\ Powerline:h17
elseif has ('gui_running')
	"set guifont=Monospace\ 13
	set guifont=Consolas:h11:cANSI:qDRAFT
	set lines=40 columns=140
endif


" ==================================
"              VUNDLE AUTO INSTALL
" "=================================
" Setting up Vundle - the vim plugin bundler
" Based on: http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')

if !filereadable(vundle_readme)
	echo "Installing Vundle.."
	echo ""
	silent !mkdir -p ~/.vim/bundle
	silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	let iCanHazVundle=0
endif

"This line must exist before vundle configuration
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Installed Plugins
" File navigation plugins
Plugin 'ctrlp.vim'
Plugin 'Tagbar'
Plugin 'The-NERD-tree'
Plugin 'bufexplorer.zip'
Plugin 'https://github.com/mileszs/ack.vim.git'
Plugin 'a.vim' " Alternate quickley between header and source files in C/C++

" Text input plugins
Plugin 'sirver/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'SearchComplete'
Plugin 'unimpaired.vim'
Plugin 'VisIncr'
Plugin 'Align'
Plugin 'http://github.com/tpope/vim-surround'
Plugin 'Raimondi/delimitMate'

" User interface plugins
Plugin 'powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'https://github.com/mhinz/vim-startify.git'
"	Plugin 'fontsize.vim'
"	Plugin 'git://github.com/altercation/vim-colors-solarized.git'
"	Plugin 'https://github.com/tpope/vim-vividchalk.git'

" Python plugins
Plugin 'indentpython.vim'
"Plugin 'klen/python-mode'
"Plugin 'pyflakes.vim'
"Plugin 'pydoc.vim'
Plugin 'pep8'
"Plugin 'pytest.vim' - did not use it so far
Plugin 'https://github.com/davidhalter/jedi-vim'

" Syntax
Plugin 'MatlabFilesEdition'
Plugin 'https://github.com/solarnz/thrift.vim'
Plugin 'mustache/vim-mustache-handlebars'
Plugin 'glench/vim-jinja2-syntax'

" Git plugins
Plugin 'http://github.com/tpope/vim-fugitive.git'
"	Plugin 'https://github.com/tpope/vim-git.git'

" Unused plugins
"Plugin 'taglist.vim'
"Plugin 'AutoComplPop'
"Plugin 'https://github.com/ervandew/supertab.git'
"Plugin 'perl-support.vim'
"Plugin 'https://github.com/sontek/rope-vim.git'
Plugin 'The-NERD-Commenter'

" General plugins
"	Plugin 'Gundo'
"	Plugin 'TaskList.vim'
"	Plugin 'https://github.com/reinh/vim-makegreen'
"	Plugin 'https://github.com/rosenfeld/conque-term'
"	Plugin 'powerman/vim-plugin-viewdoc'
Plugin 'https://github.com/brandonbloom/vim-proto'
Plugin 'tmhedberg/SimpylFold'

" C plugins
"Plugin 'https://github.com/scrooloose/syntastic.git'
" YouCompleteMe needs special manual install that is LONG but well
" explained in https://github.com/Valloric/YouCompleteMe
" Be sure to also change the compilation flags according to your
" project (instruction in YCM documentation
"Plugin 'Valloric/YouCompleteMe'

" Improved C syntax highlighting - highlights user defined functions
" These plugins provide nice functionality but slow down vim
" significantly
" Plugin 'https://github.com/xolox/vim-easytags'
" Plugin 'https://github.com/xolox/vim-misc'

" C++ Plugins
Plugin 'https://github.com/funorpain/vim-cpplint'
Plugin 'https://github.com/vim-scripts/google.vim'

" YAML
Plugin 'stephpy/vim-yaml'

"Autocompleteion
"Plugin 'autoload_cscope.vim'
"Plugin 'https://github.com/vim-scripts/cscope.vim'
Plugin 'https://github.com/chazy/cscope_maps'
"Plugin 'https://github.com/wesleyche/SrcExpl'
"Plugin 'https://github.com/Shougo/unite.vim'
"Plugin 'https://github.com/Shougo/vimproc.vim'
"Plugin 'https://github.com/terryma/vim-multiple-cursors'
"Plugin 'https://github.com/Shougo/neomru.vim'
"Plugin 'https://github.com/hewes/unite-gtags'
"Plugin 'https://github.com/h1mesuke/unite-outline'
"Plugin 'https://github.com/ervandew/supertab'
Plugin 'vimwiki/vimwiki'
Plugin 'airblade/vim-rooter' " cd to root of project when opening a file
Plugin 'editorconfig/editorconfig-vim'
Plugin 'alvan/closetag.vim'

" Swift
Plugin 'https://github.com/keith/swift.vim'
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.xml"

call vundle#end()            " required
filetype plugin indent on    " required

if iCanHazVundle == 0
        echo "Installing plugins, please ignore key map error messages"
        echo ""
        :PluginInstall
endif
" ==================================
"                 PLUGINS SETTINGS
" "=================================
"This line must exist after vundle configuration
filetype plugin indent on
au BufNewFile,BufRead *.h setlocal ft=c
au BufNewFile,BufRead *.hpp setlocal ft=c++

" Verilog Module Find
"map ` ma?^\s*\<module\><CR>Wyiw'a:echo "module -->" @0<CR>

" BuffExplorer
nnoremap <C-b> :BufExplorer<CR>

" NERDTree
let NERDTreeDirArrows=1
nnoremap <C-n> :NERDTreeToggle<CR>
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
let g:Powerline_symbols = 'unicode'
let g:Powerline_theme = 'solarized256'

" CtrlP
let g:ctrlp_cmd = 'CtrlPMixed'
let g:ctrlp_extensions = ['dir', 'mixed']
let g:ctrlp_working_path_mode = 'ra'

" Unimpaired
" Bubble single lines
nnoremap <C-Up> [e
nnoremap <C-Down> ]e
" Bubble multiple lines
vnoremap <C-Up> [egv
vnoremap <C-Down> ]egv

" Indentation Commands
nnoremap <D-[> <<
nnoremap <D-]> >>
vnoremap < <gv
vnoremap > >gv

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
nmap <leader>v :tabedit $MYVIMRC<CR>


" Tab completion
"au FileType python set omnifunc=pythoncomplete#Complete
"let g:SuperTabDefaultCompletionType = "context"

" Ack
nnoremap <leader>a <Esc>:Ack!


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

" Don't autocomplete - using YCM for autocompletion
let g:pymode_rope_completion = 0

" Jedi-vim
"let  g:jedi#use_tabs_not_buffers = 0
"let g:jedi#completions_enable = 0
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = "<leader>d"
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#rename_command = "<leader>r"
let g:jedi#show_call_signatures = "0"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#smart_auto_mappings = 0

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
nnoremap <C-
> <C-w><C-w>

"Use Ctrl+Shift+Return to rotate between windows in reverse order
nnoremap <C-S-
> <C-w>W

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
"unmap <silent> <leader>cd :cd %:p:h<cr>:pwd<cr>

" YouCompleteMe
"let g:ycm_confirm_extra_conf = 0
"let g:ycm_global_ycm_extra_conf = '~/dot_files/ycm_extra_conf.py'
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion = ['<Up>']
"let g:ycm_collect_identifiers_from_tags_files = 1
"let g:ycm_path_to_python_interpreter = '/usr/bin/python'

" Disable YCM
"set runtimepath-=~/.vim/bundle/YouCompleteMe
"set runtimepath-=~/.vim/bundle/YouCompleteMe/after
" YCM debugging
"let g:ycm_server_use_vim_stdout = 1
"let g:ycm_server_keep_logfiles = 1
"let g:ycm_server_log_level = 'debug'

"nnoremap <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" User defined Snippets
"let g:UltiSnipsSnippetsDir="~/dot_files/ultisnips/"

" Stop YCM completion with enter, in addition to default ctrl+y
"imap <expr> <CR> pumvisible() ? "\<c-y>" : "<Plug>delimitMateCR"

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

" Delete () together
"inoremap <expr> <BS> strpart(getline('.'), col('.')-2, 2) == "()" ? "\<Right><BS><BS>" : "<BS>"


" DelimitMate
au FileType c,perl let b:delimitMate_eol_marker = ";"
let delimitMate_expand_cr = 1

" Spelling
iab NYLL NULL
iab retrun return

" Commenting

" x and xx perform "cut", d and dd perform "delete"
"noremap x d
"noremap xx dd
"noremap d "_d
"noremap dd "_dd

" Emacs shortcuts
set winaltkeys=no "To enable shortcut with Alt, otherwise Alt open GUI menus.
" insert mode
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <C-o>^
inoremap <C-e> <End>
inoremap <M-b> <C-o>b
inoremap <M-f> <C-o>e<Right>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <M-d> <C-o>de
inoremap <M-h> <C-w>
inoremap <C-k> <C-o>d$

" command line mode
"cmap <C-p> <Up>
"cmap <C-n> <Down>
"cmap <C-b> <Left>
"cmap <C-f> <Right>
"cmap <C-a> <Home>
"cmap <C-e> <End>
"cmap <M-b> <S-Left>
"cmap <M-f> <S-Right>
"cnoremap <C-d> <Del>
"cnoremap <C-h> <BS>
"cnoremap <M-d> <S-Right><C-w>
"cnoremap <M-h> <C-w>
"cnoremap <C-k> <C-f>D<C-c><C-c>:<Up>


" . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
" Unite configuration
" nnoremap [unite] <Nop>
" nmap <space> [unite]
"
" let g:unite_prompt='» '
" let g:unite_data_directory='~/.vim/.cache/unite'
" "let g:unite_enable_start_insert=1
" "let g:unite_split_rule = 'botright'
"
" " yank history
" let g:unite_source_history_yank_enable = 1
" nnoremap [unite]y :Unite history/yank<cr>
"
" " buffer switching
" nnoremap [unite]b :Unite -auto-preview -no-split buffer<cr>
"
" " file matching
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])
" nnoremap <silent> [unite]p :Unite -auto-resize -no-split -auto-preview -start-insert file file_mru file_rec/async:!<cr>
"
" " unite grep
" map [unite]/ :Unite -no-split -auto-preview -auto-highlight grep:.<cr>
"
" " unite TODO/FIXME
" map [unite]d :Unite -no-split grep:.:-s:\(TODO\|FIXME\)<cr>
"
" " unite tags
" let g:unite_source_gtags_project_config = {
"   \ '/home/foo/project1/': { 'treelize': 0 },
"   \ '_':                   { 'treelize': 1 }
"   \ }
" map [unite]c :Unite gtags/context -no-split -auto-preview -auto-highlight<cr>
" map [unite]r :Unite gtags/ref -no-split -auto-preview -auto-highlight<cr>
"
" "stil missing:
"  "Find functions calling this function
"  "Find functions called by this function
"  "Find files #including this file

noremap <D-/> :call NERDComment(0, 'toggle')<cr>
inoremap <D-/> <Esc>:call NERDComment(0, 'toggle')<cr>i

" Highlight trailing white spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" CScope
nnoremap <leader>fs :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>fg :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>fc :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ft :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>fe :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <leader>ff :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <leader>fi :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <leader>fd :cs find d <C-R>=expand("<cword>")<CR><CR>
"nnoremap <leader>fa :call cscope#findInteractive(expand('<cword>'))<CR>
"nnoremap <leader>l :call ToggleLocationList()<CR>
"" s: Find this C symbol
"nnoremap  <leader>fs :call cscope#find('s', expand('<cword>'))<CR>
"" g: Find this definition
"nnoremap  <leader>fg :call cscope#find('g', expand('<cword>'))<CR>
"" d: Find functions called by this function
"nnoremap  <leader>fd :call cscope#find('d', expand('<cword>'))<CR>
"" c: Find functions calling this function
"nnoremap  <leader>fc :call cscope#find('c', expand('<cword>'))<CR>
"" t: Find this text string
"nnoremap  <leader>ft :call cscope#find('t', expand('<cword>'))<CR>
"" e: Find this egrep pattern
"nnoremap  <leader>fe :call cscope#find('e', expand('<cword>'))<CR>
"" f: Find this file
"nnoremap  <leader>ff :call cscope#find('f', expand('<cword>'))<CR>
"" i: Find files #including this file
"nnoremap  <leader>fi :call cscope#find('i', expand('<cword>'))<CR>

" Auto format json text
com! FormatJSON %!python -m json.tool

" Fold using <space>
set foldmethod=syntax
set foldlevel=99
nnoremap <space> za

" VimWiki configuration
nnoremap <Leader>wq <Plug>VimwikiVSplitLink
autocmd bufreadpre *.wiki setlocal textwidth=79

autocmd bufreadpre *.java setlocal textwidth=120 colorcolumn=120
" persistent undo
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo

" Disable arrow keys (and get used to working with hjkl)
"noremap <Up> <nop>
"noremap <Down> <nop>
"noremap <Left> <nop>
"noremap <Right> <nop>

"inoremap <Up> <nop>
"inoremap <Down> <nop>
"inoremap <Left> <nop>
"inoremap <Right> <nop>

" Open URLs and Jira tickets using <leader>u
function! HandleURL()
	let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;]*')
	let s:jira = matchstr(getline("."), 'CNDP-[1-9]*')
	let browser = 'C:\Program Files (x86)\Google\Chrome\Application\chrome.exe'
	if s:uri != ""
		silent exec '!start "' . browser . '" ' . s:uri
	elseif s:jira != ""
		let s:jira_uri = 'https://jira.cec.lab.emc.com:8443/browse/'.s:jira
		silent exec '!start "' . browser . '" ' . s:jira_uri
	else
		echo "No URI or JIRA ticket found in line."
	endif
endfunction
map <leader>u :call HandleURL()<cr>

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
