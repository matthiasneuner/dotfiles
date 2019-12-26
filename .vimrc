if $TERM == "xterm-256color"
  set t_Co=256
endif

if &term =~ '256color'
   set t_ut=
endif

set nocompatible              

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin() 
Plugin 'VundleVim/Vundle.vim'
Plugin 'psliwka/vim-smoothie'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Valloric/YouCompleteMe'
Plugin 'https://github.com/tpope/vim-commentary'
Plugin 'justinmk/vim-dirvish'
Plugin 'rdnetto/YCM-Generator' 
Plugin 'vim-scripts/visual-increment'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jnurmine/Zenburn'
Plugin 'https://github.com/lervag/vimtex'
Plugin 'KeitaNakamura/tex-conceal.vim'   
call vundle#end()            

filetype plugin indent on    

syntax enable
colorscheme zenburn
set lbr
set number
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set showmatch
set guifont=Monospace\ 9
set laststatus=2
set statusline+=%F
set hidden

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

nnoremap <silent> ,q :q<CR>
map  ,, <C-^>
nnoremap ü :YcmCompleter GoToDefinitionElseDeclaration<CR>

command W w
command Wq wq

"vim-tex and tex-conceal: 
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsListSnippets = "<C-Space>"

" let g:ycm_filetype_whitelist = { 'cpp': 1, 'h':1,  'py':1 }
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf =0
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_trigger=1
let g:ycm_max_diagnostics_to_display = 100

let g:ctrlp_cmd = 'CtrlPBuffer'

function RemoveAbaqusINPStuff()
    :%s/generate/generate=True/g
    :%s/instance=Part-1-1,//g
    :%s/instance=Part-1-1//g
endfunction
