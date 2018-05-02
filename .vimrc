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
 Plug 'scrooloose/nerdtree'
 Plug 'valloric/matchtagalways'
 Plug 'mattn/emmet-vim'
 Plug 'vim-scripts/VisIncr'
 Plug 'sheerun/vim-polyglot'
 Plug 'tomasr/molokai'
 Plug 'SirVer/ultisnips'
 Plug 'honza/vim-snippets'
 Plug 'epilande/vim-react-snippets'
 Plug 'vim-syntastic/syntastic'
 Plug 'mtscout6/syntastic-local-eslint.vim'  "Use local estlint instead of global one
 Plug 'vimwiki/vimwiki'
 Plug 'rking/ag.vim'
 Plug 'christoomey/vim-tmux-navigator'
 Plug 'tpope/vim-commentary'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  
" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Nerdtree
map <C-n> :NERDTreeToggle<CR>
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> {Left-Mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>
" Vimwiki 
let g:vimwiki_list = [{'path': '/d/OneDrive/mywiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]
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
nnoremap <leader>" bi"<esc>ea"
nnoremap <leader>' bi'<esc>ea'
inoremap {{ {{  }}<esc>2hi
inoremap {% {%  %}<esc>2hi
inoremap {!! {!!  !!}<esc>3hi
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
" }}} 

" Misc {{{
set number
set relativenumber
set ruler
filetype plugin indent on
" }}}

set modelines=1
" vim:foldmethod=marker:foldlevel=0 
