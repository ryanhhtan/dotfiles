""" General settings
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent

set path+=**                        " search files recursively
set wildmenu                         

set nu


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

" Indentation for mixed php and html file.
" Plugin 'captbaritone/better-indent-support-for-php-with-html'

" Sublime minimlist theme
Plugin 'dikiaap/minimalist'

" Laravel blade syntax highlight
Plugin 'jwalton512/vim-blade.git'


call vundle#end()                   " required
filetype plugin indent on           " required


""" Set color theme
syntax on
"color molokai
set t_Co=256
syntax on
colorscheme minimalist

""" Set netrw
"let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_liststyle = 3


""" let vim-blade.git recognize the customized directives
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['datetime', 'javascript']

" Define pairs of Blade directives. This variable is used for highlighting and indentation.
let g:blade_custom_directives_pairs = {
      \   'markdown': 'endmarkdown',
      \   'cache': 'endcache',
      \ }

""" Use ctags
command! Tags !ctags -R .
