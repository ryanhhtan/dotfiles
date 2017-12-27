#!/usr/bin/env bash
# Create new folder in ~/.vim/pack that contains a start folder and cd into it.
#
# Arguments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group syntax-highlighting
#
function set_group () {
  package_group=$1
  path="$HOME/.vim/pack/$package_group/start"
  [[ ! -d "$path" ]] && mkdir -p "$path"
  cd "$path" || exit
}
# Clone or update a git repo in the current directory.
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/tpope/vim-endwise.git
#
function package () {
  repo_url=$1
  if [[ "$repo_url" != http* ]]; then 
      repo_url="https://github.com/${repo_url}"
  fi
  expected_repo=$(basename "$repo_url" .git)
  if [ -d "$expected_repo" ]; then
    cd "$expected_repo" || exit
    result=$(git pull --force)
    echo "$expected_repo: $result"
  else
    echo "$expected_repo: Installing..."
    git clone -q "$repo_url"
  fi
}

(
set_group enhancement
package scrooloose/nerdtree 
package vim-scripts/VisIncr 
package mattn/emmet-vim
package Rip-Rip/clang_complete
#package vim-scripts/OmniCppComplete
#package roxma/nvim-yarp
#package roxma/vim-hug-neovim-rpc
#package Shougo/deoplete.nvim
wait
) &
(
set_group languagesupport 
package sheerun/vim-polyglot
#package justmao945/vim-clang
package vim-syntastic/syntastic
wait
) &
(
set_group colorschemes
package tomasr/molokai
wait
) &
wait
