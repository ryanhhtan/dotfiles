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

"let g:clang_cpp_options = '-std=c++11'

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
inoremap {{ {{  }}<esc>2hi
inoremap {% {%  %}<esc>2hi
inoremap {!! {!!  !!}<esc>3hi

"""remap esc with jk. NO ANY CHARACTER SHOULB BE PUT AFTER <ESC>
inoremap jk <esc>
inoremap <esc> <nop>
inoremap <BS> <nop>

""" auto commands
augroup filetype_php
    autocmd!
    autocmd FileType php nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType php setlocal shiftwidth=4 tabstop=4
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
    autocmd FileType javascript setlocal shiftwidth=4 tabstop=4
augroup END
augroup filetype_typescript
    autocmd!
    autocmd FileType typescript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType typescript setlocal shiftwidth=4 tabstop=4
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

"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set completefunc=ClangComplete
"let g:clang_library_path='/mingw64/bin/clang.dll'
"let g:clang_user_options="-std=c++11"

""" cpp autocomplete
"au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main

" configure tags - add additional tags here or comment out not-used ones
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
" build tags of your own project with Ctrl-F12
"map <C-F12> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
"let OmniCpp_NamespaceSearch = 1
"let OmniCpp_GlobalScopeSearch = 1
"let OmniCpp_ShowAccess = 1
"let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
"let OmniCpp_MayCompleteDot = 1 " autocomplete after .
"let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
"let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
"let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
"au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
"set completeopt=menuone,menu,longest,preview
"
let g:ycm_server_python_interpreter = '/d/dev/Python/Python36/python.exe'
let g:ycm_python_binary_path = 'python' 
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

au FileType html set filetype=htmldjango
