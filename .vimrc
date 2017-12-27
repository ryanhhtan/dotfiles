""" General settings
set nocompatible
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent

set path+=**                        " search files recursively
set wildmenu                         

set number
set relativenumber
set ruler
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete
packadd! matchit

""" Set color theme
syntax on
set background=dark
syntax on
"colorscheme 
"if !has("gui_running")
"    set term=xterm
"    set t_Co=256
"    let &t_AB="\e[48;5;%dm"
"    let &t_AF="\e[38;5;%dm"
"endif
colorscheme molokai

let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'

""" let vim-blade.git recognize the customized directives
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
            \   'markdown': 'endmarkdown',
            \   'cache': 'endcache',
            \ }

""" configure file type using alwaysmatchtag
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \}

""" Use ctags
command! MakeTags !ctags -R .

""" Take hyphen as part of a word
set iskeyword+=-

""" Key mapping
" set mapleader key
let mapleader=","
let maplocalleader="\\"

" Toggle NERDTree
map <C-n> :NERDTreeToggle<CR>

" shortcut to edit .vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<cr>

" apply the .vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

" search the selected text in visual mode
vnoremap _g y:exe "grep /" . escape(@", '\\/') . "/ *.c *.h"<CR>

""" selected substitution
nnoremap <localleader>r "ryiw
vnoremap <localleader>r "ry
nnoremap <localleader>s yiw:%s/<C-r>0/<C-r>r/g<Left><Left>
vnoremap <localleader>s y:%s/<C-r>0/<C-r>r/g<Left><Left>


"""General auto-completion 
nnoremap <leader>" bi"<esc>ea"
nnoremap <leader>' bi'<esc>ea'
inoremap {{ {{}}<esc>hi
inoremap {!! {!!!!}<esc>2hi

"""remap esc with jk. NO ANY CHARACTER SHOULB BE PUT AFTER <ESC>
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <BS> <nop>

""" auto commands
augroup filetype_php
    autocmd!
    autocmd FileType php nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType php setlocal shiftwidth=2 tabstop=2
augroup END

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

augroup filetype_python
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
augroup END

augroup filetype_vim
    autocmd!
    autocmd FileType vim nnoremap <buffer> <localleader>c I" <esc>
augroup END

""" Twiddle Case
function! TwiddleCase(str)
  if a:str ==# toupper(a:str)
    let result = tolower(a:str)
  elseif a:str ==# tolower(a:str)
    let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
  else
    let result = toupper(a:str)
  endif
  return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv

