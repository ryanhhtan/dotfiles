""" General settings
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



""" vundle: install plugins support <8.0
set nocompatible                    " be iMproved, required
filetype off                        " required
set rtp+=~/.vim/bundle/Vundle.vim   " set the runtime path to include Vundle and initialize
call vundle#begin()

"" add more needed plugins here
" Plugin manager
Plugin 'VundleVim/Vundle.vim'

" Web development toolkit
Plugin 'mattn/emmet-vim'

" NERDtree
Plugin 'scrooloose/nerdtree'

" Sublime minimlist theme
Plugin 'rafi/awesome-vim-colorschemes'

" Laravel blade syntax highlight
Plugin 'jwalton512/vim-blade.git'

"polyglot -multiple programming languages support
Plugin 'sheerun/vim-polyglot'

"javascript-vim
Plugin 'pangloss/vim-javascript'

"match-tag-always
Plugin 'Valloric/MatchTagAlways'

"insert incresing number in multiple line 
Plugin 'vim-scripts/VisIncr'

"yaml format
Plugin 'shmay/vim-yaml'

call vundle#end()                   " required
filetype plugin indent on           " required


""" Set color theme
syntax on
"color molokai
"set t_Co=256
set background=dark
set term=xterm
set t_Co=256
let &t_AB="\e[48;5;%dm"
let &t_AF="\e[38;5;%dm"
syntax on
"colorscheme minimalist
"colorscheme dracula 
colorscheme molokai



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
augroup END

augroup filetype_javascript
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
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

