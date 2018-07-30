" Custom Functions {{{ """ 
" Install YouCompleteMe with condition 
" function! BuildYCM(info) " info is a dictionary with 3 fields " - name:   name of the plugin " - status: 'installed', 'updated', or 'unchanged'
"   " - force:  set on PlugInstall! or PlugUpdate!
"   if a:info.status == 'installed' || a:info.force
"     !./install.py
"   else  
"     ./install.py --java-completer --js-completer --clang-completer 
"   endif
" endfunction
" }}}

" Plugin Manager - Vim-Plug  {{{  
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Install the plugin manager itself 
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Install plugins
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'artur-shaik/vim-javacomplete2'        " Code completion tool for java
Plug 'christoomey/vim-tmux-navigator'       " navigate among diffiern panes in tmux 
Plugin 'hsanson/vim-android'
Plug 'epilande/vim-react-snippets'          " Auto generating React snippets 
Plug 'honza/vim-snippets'
Plug 'idanarye/vim-vebugger'                " vim-vebugger
\, {'do': 'git checkout develop' }
Plug 'jparise/vim-graphql'                  " Hightline and indentation fro UraphQL 
Plug 'mattn/emmet-vim'                      " Auto generating HTML tags 
Plug 'mattn/calendar-vim'                   " A plugin to select date with cursor 
Plug 'mtscout6/syntastic-local-eslint.vim'  " Use local estlint instead of global one
Plug 'neomake/neomake'                      " Required by VimStudio
Plug 'prettier/vim-prettier'                " Prettier - a javascript formatter
\, { 'do': 'yarn install' } 
Plug 'Shougo/vimproc.vim'                   " vimproc -- required by vim-prettier
\, {'do' : 'make'}  
Plug 'Quramy/tsuquyomi'                     " TypeScript language server 
Plug 'rking/ag.vim'                         " Searching files asynchornously
Plug 'roxma/nvim-yarp'                      " Required by deplete
Plug 'roxma/vim-hug-neovim-rpc'             " Required by deplete
Plug 'sheerun/vim-polyglot'                 " Collection of syntax and indentation
Plug 'scrooloose/nerdtree'                  " Browse/manage files in tree view 
Plug 'Shougo/denite.nvim'                   " File search 
Plug 'Shougo/deoplete.nvim'                 " Auto completion plugin
Plug 'SirVer/ultisnips'                     " General sinippets management
Plug 'tpope/vim-commentary'                 " Comment/uncomment code  
Plug 'tpope/vim-surround'                   " Change surrounding, e.g: quotation. 
Plug 'tpope/vim-fugitive'                   " Vim git integration
Plug 'tomasr/molokai'                       " Color theme  
Plug 'valloric/matchtagalways'              " Show the matching tag 
Plug 'vim-scripts/VisIncr'                  " Add numbers incresingly
" Plug 'vim-syntastic/syntastic'              " Syntaxt checker 
Plug 'vimwiki/vimwiki'                      " personal wiki management
Plug 'Xuyuanp/nerdtree-git-plugin'          " Alway onpen NERDtree at start up

"Plugin List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  
" Deplete
let g:deoplete#enable_at_startup = 1
"" Deplete with neosnippet
" let g:neosnippet#enable_completed_snippet = 1

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Nerdtree
map <C-n> :NERDTreeToggle<CR>
" Syntastic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_javascript_checkers = ['eslint']
"" Java
" let g:syntastic_java_checkers=['javac']
" let g:syntastic_java_javac_config_file_enabled = 1
"" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
" Vimwiki 
let g:vimwiki_list = [{'path': '/d/OneDrive/mywiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
" Nedtree 
augroup nerdtree
"" No duplicated autocmd
autocmd!
"" Open Nedtree automatically when starting up
autocmd vimenter * NERDTree
"" Open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"" close vim if the only window left open is a NERDTree 
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" Prettier
"" auto format without //@format 
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
"" Single quote over double quote
let g:prettier#config#single_quote = 'true'
"" Print spaces between bracket 
let g:prettier#config#bracket_spacing = 'true'

" Java-complete2
" let g:JavaComplete_JavaCompiler="/usr/bin/javac"
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" }}}

" Colors & Theme {{{
syntax on
colorscheme molokai
" }}}

" Tabs & Spaces {{{ 
set nocompatible
set expandtab                      	"convert tab to spaces
set shiftwidth=4
set softtabstop=4
set tabstop=4
" }}}

" Folding {{{
set foldenable
set foldmethod=indent
" }}}

" File searching {{{
set path+=**         			    " search files recursively
set wildmenu                        " displays the matched files when fuzzy searching  
" }}}

" Key mappings {{{ 
" replace ESC with 'jk'  
inoremap jk <ESC>
inoremap JK <ESC>
inoremap <esc> <nop>
inoremap <BS> <nop>
" set leader key to ',' 
let mapleader="," 
let maplocalleader="\\"
" shortcut to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
" apply the .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

""Auto completion for braces, blackets and quotation marks 
" nnoremap <leader>" bi"<esc>ea"
" nnoremap <leader>' bi'<esc>ea'
inoremap {{ {{  }}<esc>2hi
inoremap {% {%  %}<esc>2hi
inoremap {!! {!!  !!}<esc>3hi

"vim-surround
nmap <leader>qq ysiw" 
nmap <leader>qs ysiw' 
nmap <leader>qt ysiw` 

""Auto insert datetime surroundee with '_' 
nnoremap <leader>dt :-1read !date<cr>i_<esc>$a_

"" Tag a line as sction in vimwiki
nnoremap <leader>ts 0d$i[<esc>pa](#<esc>pa)<esc>F]

"" Input code block in vimwiki
inoremap ``` ```<cr>```<esc>O

"" YouCompleteMe
nnoremap <leader>f :YcmCompleter FixIt<cr>
nnoremap <leader>jd :YcmCompleter GoTo<cr>
nnoremap <leader>gd :YcmCompleter GetDoc<cr>

"" Tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>
nnoremap <c-f> :Denite file/rec<cr>
nnoremap <c-b> :Denite buffer<cr>
" call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
" call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

"" vim-vebugger
let g:vebugger_leader="<Leader>d"
" }}}

" Augroups {{{ 
augroup filetype_html
    autocmd!
    autocmd FileType html setlocal shiftwidth=2 tabstop=2
augroup END

augroup filetype_json
    autocmd!
    autocmd FileType json setlocal shiftwidth=2 tabstop=2
augroup END

augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup END

augroup filetype_typescript
    autocmd!
    autocmd FileType typescript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
augroup END

augroup filetype_vimwiki
    autocmd!
    autocmd FileType vimwiki setlocal spell spelllang=en_us
augroup END

augroup filetype_graphql
    autocmd!
    autocmd FileType graphql setlocal shiftwidth=2 tabstop=2
augroup END

augroup realtive_path_complete
    autocmd!
    autocmd InsertEnter * let save_cwd = getcwd() | set autochdir
    autocmd InsertLeave * set noautochdir | execute 'cd' fnameescape(save_cwd)
augroup END


" }}} 

" Statusline {{{ 
set statusline=
set statusline+=\ Branch:
set statusline+=\ %{fugitive#statusline()}
set statusline+=\ \     
set statusline+=\ File:
set statusline+=\ %f
set statusline+=\ \  
set statusline+=\ Line: 
set statusline+=%l    " Current line
set statusline+=/    " Separator
set statusline+=%L   " Total lines
" Syntastic
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" }}} 

" Misc {{{
set number
set relativenumber
set ruler
set spellfile=/d/OneDrive/vim_spell/en.utf-8.add
filetype plugin indent on
"" Always show status line, disable with value of 0 
set laststatus=2

" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0 
