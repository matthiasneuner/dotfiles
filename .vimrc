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
set guifont=Monospace\ 9
set laststatus=2
set statusline+=%F
set hidden
set noshowmatch
set conceallevel=1

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

nnoremap <silent> ,q :q<CR>
map  ,, <C-^>
nnoremap ü :YcmCompleter GoToDefinitionElseDeclaration<CR>

command W w
command Wq wq

"vimtex and tex-conceal: 
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_close_braces=1 "otherwise more or less useless
let g:vimtex_matchparen_enabled=0 "don't be sluggish!

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"
let g:UltiSnipsListSnippets = "<C-Space>"

" let g:ycm_filetype_whitelist = { 'cpp': 1, 'h':1,  'py':1 }
let g:ycm_autoclose_preview_window_after_completion=0
let g:ycm_autoclose_preview_window_after_insertion=1
let g:ycm_confirm_extra_conf = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_auto_trigger=1
let g:ycm_max_diagnostics_to_display = 100
let g:ycm_min_num_identifier_candidate_chars = 1000 " 'disable' identifier completion list

let g:ctrlp_cmd = 'CtrlPBuffer'

" completion for vimtex
if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

function RemoveAbaqusINPStuff()
    :%s/generate/generate=True/g
    :%s/instance=Part-1-1,//g
    :%s/instance=Part-1-1//g
endfunction
