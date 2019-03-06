" Initial settings {{{
set nocompatible
set encoding=utf-8
set wildignore=vendor/**,node_modules/**
" }}}
"
" Custom Functions {{{  
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
""" Language client 
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
""" Tmux pane-navigation 
Plug 'christoomey/vim-tmux-navigator'       

""" Table mode
Plug 'dhruvasagar/vim-table-mode'

""" Auto generating React snippets 
Plug 'epilande/vim-react-snippets'          

""" Code snippets for multiple languages.
Plug 'honza/vim-snippets'

""" Debugger frontend
Plug 'idanarye/vim-vebugger', {
   \ 'branch': 'develop' ,
   \ }

"""" Hightline and indentation fro UraphQL 
"" Plug 'jparise/vim-graphql'

""" Fuzzy file finder and Multi-entry selection, for LanguagClient neovim
Plug 'junegunn/fzf', {
   \ 'dir': '~/.fzf', 
   \ 'do': './install --all'
   \ }
Plug 'junegunn/fzf.vim'
" Auto generating HTML/XML tags 
Plug 'mattn/emmet-vim'

""" A plugin to select date with cursor 
Plug 'mattn/calendar-vim'

""" Manage searching tools for vim
Plug 'mileszs/ack.vim'

""" Required by VimStudio
Plug 'neomake/neomake'

""" Prettier - a javascript formatter
Plug 'prettier/vim-prettier', {
    \  'do': 'yarn install' 
    \ } 

""" vimproc -- required by vim-prettier
Plug 'Shougo/vimproc.vim', {                
    \ 'do' : 'make'
    \ }  

""" TypeScript language server 
Plug 'Quramy/tsuquyomi'

""" Searching files asynchornously
Plug 'rking/ag.vim'                         

""" Required by deoplete
Plug 'roxma/nvim-yarp'

""" Required by deoplete
Plug 'roxma/vim-hug-neovim-rpc'

""" Php language server
Plug 'roxma/LanguageServer-php-neovim'

""" Hightline the same word under the cursor
Plug 'RRethy/vim-illuminate'

""" Collection of syntax and indentation
Plug 'sheerun/vim-polyglot'

""" Browse/manage files in tree view 
Plug 'scrooloose/nerdtree'

""" File search 
Plug 'Shougo/denite.nvim'

""" Auto completion plugin
Plug 'Shougo/deoplete.nvim', {
    \ 'do': 'UpdateRemotePlugins'
    \ }

""" General sinippets management
Plug 'SirVer/ultisnips'

""" Comment/uncomment code  
Plug 'tpope/vim-commentary'

""" Change surrounding, e.g: quotation. 
Plug 'tpope/vim-surround'

""" Vim git integration
Plug 'tpope/vim-fugitive'

""" Color theme  
Plug 'tomasr/molokai'

""" Show the matching tag 
Plug 'valloric/matchtagalways'

""" Kotlin
Plug 'udalov/kotlin-vim'

""" Add numbers incresingly
Plug 'vim-scripts/VisIncr'

""" personal wiki management
Plug 'vimwiki/vimwiki'

""" Alway onpen NERDtree at start up
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'felixfbecker/php-language-server', {'do': 'composer install && composer run-script parse-stubs'}

"Plugin List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  
"
"" Deplete
let g:deoplete#enable_at_startup = 1

"" UltiSnip
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/d/OneDrive/mysnips/"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "/d/OneDrive/mysnips/"]

"" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1

"" Vimwiki 
let g:vimwiki_list = [{'path': '/d/OneDrive/mywiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
"" Nedtree 
map <c-d> :NERDTreeToggle<CR>
" augroup nerdtree
" "" No duplicated autocmd
" autocmd!
" "" Open Nedtree automatically when starting up
" autocmd vimenter * NERDTree
" "" Open a NERDTree automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" "" close vim if the only window left open is a NERDTree 
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" augroup END

"" Prettier
""" auto format without //@format 
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
""" Single quote over double quote
let g:prettier#config#single_quote = 'true'
""" Print spaces between bracket 
let g:prettier#config#bracket_spacing = 'true'

"" LanguageClient-neo
""" General
"""" Help LC identify root of the project 
let g:LanguageClient_rootMarkers = {
    \ 'javascript.jsx': ['package.json'],
    \ 'rust': ['Cargo.toml'],
    \ 'java': ['pom.xml', 'build.gradle'],
    \ 'kotlin': ['pom.xml', 'build.gradle'],
    \ }
"""" Starting CMD for languages
let g:LanguageClient_serverCommands = {
    \ 'java': ['jdtls'],
    \ 'kotlin': ['kls'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ 'typescript': ['javascript-typescript-stdio'],
    \ }
"""" Alway show the sign column to avoid blinking
set signcolumn=yes
"""" Never show hover infomation in preview window
let g:LanguageClient_hoverPreview = 'never'
"""" Use LanguageClient formater
" set formatexpr=LanguageClient#textDocument_rangeFormatting_sync()

"" Vim-jsx-typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=javascript.jsx

"" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"" Silver search ag with Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"" Denite
call denite#custom#var('file/rec', 'command',
     \ ['ag', '--follow', '--nocolor', '--nogroup', '--ignore=*.class', '-g', ''])

"" vim-illuminate
hi link illuminatedWord Visual

"" Vebugger
let g:vebugger_use_tags=1
" }}}

" Colors & Theme {{{
syntax on
colorscheme molokai
" colorscheme cobalt2
" }}}
set hlsearch

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

"" Tag a line as sction in vimwiki
nnoremap <leader>ts 0d$i[<esc>pa](#<esc>pa)<esc>F]

"" Input code block in vimwiki
inoremap ``` ```<cr>```<esc>O

" LanguageClient
nnoremap <leader>f :call LanguageClient_textDocument_codeAction()<cr>
" nnoremap <silent> <c-d> :call LanguageClient_textDocument_definition({'gotoCmd': 'vsplit'})<cr>
nnoremap <leader>d :call LanguageClient_textDocument_definition()<cr>
nnoremap <leader>m :call LanguageClient_contextMenu()<cr>
nnoremap <leader>h :call LanguageClient#textDocument_hover()<CR>

" Tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>

" Denite
" nnoremap <c-f> :Denite file/rec<cr>
nnoremap <c-f> :FZF<cr>

call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')

" vim-vebugger
let g:vebugger_leader="<Leader>d"
nnoremap <Leader>da :call vebugger#jdb#attach('5005', {'srcpath': 'src/main/java'})

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

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
    autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
augroup END

augroup filetype_typescript
    autocmd!
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
set statusline+=\ \  
set statusline+=\ Col: 
set statusline+=%c   " Total lines
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
