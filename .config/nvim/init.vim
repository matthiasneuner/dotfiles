set runtimepath^=~/.vim runtimepath+=~/.vim/after

let &packpath=&runtimepath
source ~/.vimrc

set nohlsearch

" special command for nvim to edit snippts in standard vims directory
:command UltiSnipsEdiNVIM :UltiSnipsEdit ../../../.vim/UltiSnips

