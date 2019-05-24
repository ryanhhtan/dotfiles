  " Initial settings {{{
  set nocompatible
  set encoding=utf-8
  set wildignore=vendor/**,node_modules/**
  set signcolumn=yes
  syntax on
  set hlsearch
  set cmdheight=2
  " set leader key to ',' 
  let mapleader="," 
  let maplocalleader="\\"
  " set cursor styles in different mode
  let &t_SI = "\<esc>[5 q"  " blinking I-beam in insert mode
  let &t_SR = "\<esc>[3 q"  " blinking underline in replace mode
  let &t_EI = "\<esc>[ q"  " default cursor (usually blinking block) otherwise
  " use true color if possible
  if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
  endif
  " file explorer settings
  let g:netrw_banner = 0
  let g:netrw_browse_split = 4
  let g:netrw_list_hide=".*.swp"
  " }}}
  "
" Custom Functions {{{

function! ReplaceUnderCursor() 
  let s:wordUnderCourser = expand("<cword>")
  call inputsave()
  let s:replceText = input('Replace all occurences of "'. s:wordUnderCourser .'" with: ')
  call inputrestore()
  execute "%s/" . s:wordUnderCourser . "/" . s:replceText . "/g"
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

""" My own helper plugin
Plug 'ryanhhtan/vim-helpers'

""" Collection of syntax and indentation
Plug 'sheerun/vim-polyglot'

""" General sinippets management
Plug 'SirVer/ultisnips'

""" Comment/uncomment code  
Plug 'tpope/vim-commentary'

""" Change surrounding, e.g: quotation. 
Plug 'tpope/vim-surround'

""" Vim git integration
Plug 'tpope/vim-fugitive'

""" Color theme  
Plug 'rafi/awesome-vim-colorschemes' 

""" Show the matching tag 
Plug 'valloric/matchtagalways'

""" Add numbers incresingly
Plug 'vim-scripts/VisIncr'

""" personal wiki management
Plug 'vimwiki/vimwiki'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plugin List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  
"" Color scheme option
"" this setting must go before changing highlight colors
colorscheme dracula

"" UltiSnip
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsSnippetsDir="/d/OneDrive/mysnips/"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "/d/OneDrive/mysnips/"]

"" Vim Tmux Navigator
let g:tmux_navigator_no_mappings = 1

"" Vimwiki 
let g:vimwiki_list = [{'path': '/d/OneDrive/mywiki/',
            \ 'syntax': 'markdown', 'ext': '.md'}]

"" Ack
if executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

"" Silver search ag with Ack
let g:ackprg = 'ag --nogroup --nocolor --column'

"" vim-illuminate
" hi link illuminatedWord Visual

"" Vebugger
let g:vebugger_use_tags=1

""fzf completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"" coc-nvim
""" Extensions
let g:coc_global_extensions = ['coc-java', 'coc-json', 'coc-python', 'coc-html', 'coc-css', 'coc-snippets', 'coc-yaml', 'coc-tsserver', 'coc-tslint-plugin', 'coc-phpls', 'coc-highlight', 'coc-lists']

""" if hidden is not set, TextEdit might fail.
set hidden

"""" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

""" change default hight color scheme
hi CocHighlightText guibg=#666666 ctermbg=Grey

""" highlight current symbol 
set updatetime=1000
autocmd CursorHold * silent call CocAction('highlight')

""" don't give |ins-completion-menu| messages.
set shortmess+=c

""" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

""" 
" Use <CR>> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR>> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

""" Use `[e` and `]e` to navigate diagnostics
nmap <silent> [e <Plug>(coc-diagnostic-prev)
nmap <silent> ]e <Plug>(coc-diagnostic-next)

"""" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

""" key mappings
nmap <leader>f <Plug>(coc-codeaction)
nmap <leader>rn <Plug>(coc-rename)
""" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
""" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)
""" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')
""" Using CocList
"""" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>>
"""" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>>
"""" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>>
"""" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>>
"""" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<CR>>
"""" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"""" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"""" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Fugitive key mappings
nnoremap <leader>gs :Gstatus<CR>>
nnoremap <leader>gw :Gwrite<CR>>
nnoremap <leader>gc :Gcommit -s -S<CR>>
nnoremap <leader>gd :Gdiff<CR>>
nnoremap <leader>gp :Gpush<CR>>
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
nnoremap <leader>ev :vsplit $MYVIMRC<CR>>
" apply the .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>>

""Auto completion for braces, blackets and quotation marks 
" nnoremap <leader>" bi"<esc>ea"
" nnoremap <leader>' bi'<esc>ea'
inoremap {{ {{  }}<esc>2hi
inoremap {% {%  %}<esc>2hi
inoremap {!! {!!  !!}<esc>3hi

""Replace the word under cursor
nnoremap <leader>rr :call ReplaceUnderCursor()<CR>>

"" Force redraw
nnoremap <leader>rd :redraw!<CR>>

"vim-surround
nmap <leader>qq ysiw" 
nmap <leader>qs ysiw' 
nmap <leader>qt ysiw` 

"" Tag a line as sction in vimwiki
nnoremap <leader>ts 0d$i[<esc>pa](#<esc>pa)<esc>F]

"" Input code block in vimwiki
inoremap ``` ```<CR>>```<esc>O

" Tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<CR>>
nnoremap <silent> <c-j> :TmuxNavigateDown<CR>>
nnoremap <silent> <c-k> :TmuxNavigateUp<CR>>
nnoremap <silent> <c-l> :TmuxNavigateRight<CR>>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<CR>>

" Denite
" nnoremap <c-f> :Denite file/rec<CR>>
nnoremap <c-f> :FZF<CR>>

" vim-vebugger
let g:vebugger_leader="<Leader>d"
nnoremap <Leader>da :call vebugger#jdb#attach('5005', {'srcpath': 'src/main/java'})

" UltiSnip
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-l>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Open file explorer
nnoremap <silent> <c-d> :Vex<CR>>  
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
