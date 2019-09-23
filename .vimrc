  " Initial settings {{{
set nocompatible
set encoding=utf-8
" set wildignore=vendor/**,node_modules/**
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
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" use true color if possible
if has('termguicolors')
  set termguicolors
  " keep background in vim and tmux consistent
  set t_ut=
endif
" file explorer settings
let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
let g:netrw_keepdir= 0
autocmd FileType netrw setlocal bufhidden=delete
autocmd VimEnter * let g:netrw_list_hide = netrw_gitignore#Hide()
" }}}
  
" Custom Functions {{{
" execute shell command and show output in a file
" Ref https://stackoverflow.com/questions/10493452/vim-open-a-temporary-buffer-displaying-executables-output
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell

" end custom functions
" }}}

" Custom commands {{{
command! -nargs=1 Silent
\   execute 'silent !' . <q-args>
\ | execute 'redraw!'
"" remember the initial direcotry
autocmd VimEnter * silent! let g:initial_dir=execute("pwd") 
autocmd BufLeave * silent! if &filetype == 'netrw' | cd `=g:initial_dir` | endif
"}}}

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

" Color schemes
Plug 'dracula/vim', { 'as': 'dracula' }

""" Debugger frontend
Plug 'idanarye/vim-vebugger', {
   \ 'branch': 'develop' ,
   \ }

""" Intellisense engine: Conquer of Completion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

""" A plugin to select date with cursor 
Plug 'mattn/calendar-vim'

""" Vim Tmux clipboard
Plug 'roxma/vim-tmux-clipboard'

""" My own helper plugin
Plug 'ryanhhtan/vim-helpers'

""" Collection of syntax and indentation
Plug 'sheerun/vim-polyglot'
" Plug 'MaxMEllon/vim-jsx-pretty'

""" asynchronous execution library for Vim, required by vebugger 
Plug 'Shougo/vimproc.vim', {'do' : 'make'}

""" Tmux focus event detecting plugin, required by vim-tmux-clipboard
Plug 'tmux-plugins/vim-tmux-focus-events'

""" Comment/uncomment code  
Plug 'tpope/vim-commentary'

""" Change surrounding, e.g: quotation. 
Plug 'tpope/vim-surround'

""" Vim git integration
Plug 'tpope/vim-fugitive'

""" add-on for netrw
Plug 'tpope/vim-vinegar'

""" Add numbers incresingly
Plug 'vim-scripts/VisIncr'

""" personal wiki management
Plug 'vimwiki/vimwiki'

""" status line
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

"Plugin List ends here. Plugins become visible to Vim after this call.
call plug#end()
" }}}

" Plugin Settings {{{  

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

"" Vebugger
let g:vebugger_use_tags=1

""fzf completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

"" coc-nvim
""" Extensions
let g:coc_global_extensions = ['coc-java', 'coc-json', 'coc-python', 'coc-html', 'coc-xml', 'coc-emmet', 'coc-css', 'coc-snippets', 'coc-yaml', 'coc-tsserver', 'coc-tslint-plugin', 'coc-phpls', 'coc-highlight', 'coc-lists']

""" if hidden is not set, TextEdit might fail.
set hidden

"""" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

""" change default hight color scheme
hi CocHighlightText guibg=#666666 ctermbg=Grey

""" highlight current symbol 
set updatetime=1000
autocmd CursorHold * silent call CocActionAsync('highlight')

""" don't give |ins-completion-menu| messages.
set shortmess+=c

""" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

""" 
" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

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
    call CocActionAsync('doHover')
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
command! -nargs=0 Format :call CocActionAsync('format')
""" Using CocList
"""" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<CR>
"""" Show files under current working directory and sub-directories
nnoremap <silent> <space>f  :<C-u>CocList files<CR>
"""" Show most recent used buffers
nnoremap <silent> <space>m  :<C-u>CocList mru<CR>
"""" Show most recent used buffers
nnoremap <space>g  :<C-u>CocList grep 
"""" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<CR>
"""" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<CR>
"""" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<CR>
"""" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<CR>
"""" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"""" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"""" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
""" coc-snippets
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Fugitive key mappings
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gw :Gwrite<CR>
nnoremap <leader>gc :Gcommit -s -S<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gp :Gpush<CR>

" vim table mode

function! s:isAtStartOfLine(mapping)
  let text_before_cursor = getline('.')[0 : col('.')-1]
  let mapping_pattern = '\V' . escape(a:mapping, '\')
  let comment_pattern = '\V' . escape(substitute(&l:commentstring, '%s.*$', '', ''), '\')
  return (text_before_cursor =~? '^' . ('\v(' . comment_pattern . '\v)?') . '\s*\v' . mapping_pattern . '\v$')
endfunction

inoreabbrev <expr> <bar><bar>
          \ <SID>isAtStartOfLine('\|\|') ?
          \ '<c-o>:TableModeEnable<cr><bar><space><bar><left><left>' : '<bar><bar>'
inoreabbrev <expr> __
          \ <SID>isAtStartOfLine('__') ?
          \ '<c-o>:silent! TableModeDisable<cr>' : '__'
"
"" Color scheme option
"" this setting must go before changing highlight colors
colorscheme dracula
hi! link Pmenu DraculaCyan
" }}}

" Tabs & Spaces {{{ 
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
" disable backspace
inoremap <BS> <nop>
imap <C-U> <ESC>viwUA
" shortcut to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
" apply the .vimrc
nnoremap <leader>sv :source $MYVIMRC<CR>

""Auto completion for braces, blackets and quotation marks 
" nnoremap <leader>" bi"<esc>ea"
" nnoremap <leader>' bi'<esc>ea'
inoremap {} {}<LEFT>
inoremap () ()<LEFT>
inoremap [] []<LEFT>
inoremap {{ {{  }}<LEFT><LEFT><LEFT>
inoremap {{{ {{{  }}}<LEFT><LEFT><LEFT><LEFT>
inoremap [[ [[  ]]<LEFT><LEFT><LEFT>
nnoremap <leader>q" F=ebi"<ESC>$bea"<LEFT>
nnoremap <leader>q' F=ebi'<ESC>$bea'<LEFT>

""Replace the word under cursor
nnoremap <leader>rr :%s/\<<C-R><C-W>\>//g<LEFT><LEFT>

"" Force redraw
nnoremap <leader>rd :redraw!<CR>

"vim-surround
nmap <leader>qq ysiw" 
nmap <leader>qs ysiw' 
nmap <leader>qt ysiw` 

"" Tag a line as sction in vimwiki
nnoremap <leader>ts 0d$i[<esc>pa](#<esc>pa)<esc>F]

"" Input code block in vimwiki
inoremap ``` ```<CR>```<ESC>O
inoremap `` ``<LEFT>

"" Auto completion of frequently used formats
inoremap "" ""<ESC>i

" Tmux
nnoremap <silent> <c-h> :TmuxNavigateLeft<CR>
nnoremap <silent> <c-j> :TmuxNavigateDown<CR>
nnoremap <silent> <c-k> :TmuxNavigateUp<CR>
nnoremap <silent> <c-l> :TmuxNavigateRight<CR>
nnoremap <silent> <c-p> :TmuxNavigatePrevious<CR>

" vim-vebugger
let g:vebugger_leader="<Leader>d"
nnoremap <Leader>da :call vebugger#jdb#attach('5005', {'srcpath': 'src/main/java'})

" UltiSnip
" let g:UltiSnipsExpandTrigger="<tab>" -- coc trigger instead
" let g:UltiSnipsListSnippets="<c-l>"
" let g:UltiSnipsJumpForwardTrigger="<TAB>"
" let g:UltiSnipsJumpBackwardTrigger="<s-Tab>"

" Open file explorer
nnoremap <silent> <c-d> :Vex<CR>  

nnoremap <Leader>tf :!tmux send-keys -t 1 './mvnw clean test -Dtest=%:t\#<cword> -Dspring.profiles.active=local,test' Enter<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
nnoremap <Leader>tc :!tmux send-keys -t 1 './mvnw clean test -Dtest=%:t -Dspring.profiles.active=local,test' Enter<LEFT><LEFT><LEFT><LEFT><LEFT><LEFT><LEFT>
" }}}

" Augroups {{{ 
" augroup java_spaces
"     autocmd!
"     autocmd filetype java setlocal shiftwidth=2 softtabstop=2 tabstop=2
" augroup END
" }}} 
"
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
