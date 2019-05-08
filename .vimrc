" Initial settings {{{
set nocompatible
set encoding=utf-8
set wildignore=vendor/**,node_modules/**
set signcolumn=yes
" set leader key to ',' 
let mapleader="," 
let maplocalleader="\\"
" set cursor styles in different mode
let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise
" }}}
"
" Custom Functions {{{
function RollbackStatement(statement)
  let tokens = split(a:statement, ' ')
  let rollback = ['--rollback']
  if tokens[0] ==? 'CREATE'
    let rollback = rollback + ['DROP'] + tokens[1:2]
    return join(rollback) . ';'
  endif
  if tokens[0] ==? 'ALTER'
    let rollback = rollback + tokens[0:2] + ['DROP'] + tokens[4:5]
    return join(rollback) . ';'
  endif
endfunction 

function RollbackMysqlStatement(statement)
  let tokens = split(a:statement, ' ')
  let rollback = ['--rollback']
  if tokens[0] ==? 'CREATE'
    if tokens[1] ==? 'TABLE'
      let rollback = rollback + ['DROP'] + tokens[1:2]
      return join(rollback) . ';'
    endif
    if tokens[1] ==? 'INDEX'
      let rollback = rollback + ['ALTER', 'TABLE', substitute(tokens[4], '\v\(.+', '', 'g')] + ['DROP', 'INDEX', tokens[2] ] 
      return join(rollback) . ';'
    endif
  endif
  if tokens[0] ==? 'ALTER'
    if tokens[6] ==? 'FOREIGN'
      let rollback = rollback + tokens[0:2] + ['DROP'] + tokens[6:7] + [tokens[5]]
      return join(rollback) . ';'
    endif
  endif
endfunction

function SqlRollbackScript()
  let dbtype = split(expand('%:t:r'), '\v\.')[-1]
  echom dbtype
  execute "normal! gg"
  while 1
    let b:current = line('.')
    if b:current == line('$') 
      break
    endif
    let b:currentLine = getline(b:current)
    let b:nexttLine = getline(b:current + 1)
    if strlen(b:currentLine) == 0 || b:currentLine[0:1] == '--' || b:nexttLine[0:9] == '--rollback' 
      execute "normal! j"
      continue
    endif
    if dbtype == 'mysql'
      call append(b:current, RollbackMysqlStatement(b:currentLine))
    else 
      call append(b:current, RollbackStatement(b:currentLine))
    endif
    execute "normal! j"
  endw
endfunction 

" end custom functions
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

Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}

" Auto generating HTML/XML tags 
Plug 'mattn/emmet-vim'

""" A plugin to select date with cursor 
Plug 'mattn/calendar-vim'

""" Manage searching tools for vim
Plug 'mileszs/ack.vim'

""" Searching files asynchornously
Plug 'rking/ag.vim'                         

""" Hightline the same word under the cursor
Plug 'RRethy/vim-illuminate'

""" Collection of syntax and indentation
Plug 'sheerun/vim-polyglot'

""" Browse/manage files in tree view 
Plug 'scrooloose/nerdtree'

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

""" Add numbers incresingly
Plug 'vim-scripts/VisIncr'

""" personal wiki management
Plug 'vimwiki/vimwiki'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

""" Alway onpen NERDtree at start up
Plug 'Xuyuanp/nerdtree-git-plugin'


"Plugin List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  
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

"" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"" Silver search ag with Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"" vim-illuminate
hi link illuminatedWord Visual

"" Vebugger
let g:vebugger_use_tags=1

""fzf completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"" coc-nvim
""" Extensions
let g:coc_global_extensions = ['coc-java', 'coc-json', 'coc-python', 'coc-html', 'coc-css', 'coc-snippets', 'coc-yaml', 'coc-tsserver', 'coc-tslint-plugin']
""" key mappings
nmap <leader>f <Plug>(coc-codeaction)
nmap <c-]> <Plug>(coc-definition)
" nmap <leader>f <Plug>(coc-rename)

" }}}

" Colors & Theme {{{
syntax on
colorscheme molokai
set hlsearch
set cmdheight=2
" colorscheme cobalt2
" }}}

" Tabs & Spaces {{{ 
set nocompatible
set expandtab                      	"convert tab to spaces
set shiftwidth=2
set softtabstop=2
set tabstop=2
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
inoremap <BS> <nop>
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

" Tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
nnoremap <silent> <c-l> :TmuxNavigateRight<cr>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<cr>

" Denite
" nnoremap <c-f> :Denite file/rec<cr>
nnoremap <c-f> :FZF<cr>

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
augroup java_spaces
    autocmd!
    autocmd filetype java setlocal shiftwidth=4 softtabstop=4 tabstop=4
augroup END

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
