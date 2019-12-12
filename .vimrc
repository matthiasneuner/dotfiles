if $TERM == "xterm-256color"
  set t_Co=256
endif

if &term =~ '256color'
   set t_ut=
endif
set nocompatible              " be iMproved, required call system('wmctrl -i -b add,maximized_vert,maximized_horz -r '.v:windowid) filetype off                  " required
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
Plugin 'vim-latex/vim-latex' 
Plugin 'vim-scripts/visual-increment'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jnurmine/Zenburn'
call vundle#end()            " required

"Vim Latex-Suite
filetype plugin indent on    " required
if has('gui_running')
  set grepprg=grep\ -nH\ $*
  filetype indent on
  let g:tex_flavor='latex'
endif
au BufEnter *.tex set autowrite
let g:Tex_BibtexFlavor = 'biber'
let g:Tex_DefaultTargetFormat = 'pdf'
let g:Tex_CompileRule_pdf = 'pdflatex -shell-escape -file-line-error -interaction=nonstopmode -synctex=1 $*'
let g:Tex_GotoError=0
let g:Tex_ShowErrorContext = 0
let g:Tex_ViewRule_pdf = 'okular'
function! SyncTexForward()
     let execstr = "silent !okular --unique %:p:r.pdf\\#src:".line(".")."%:p &"
     exec execstr
endfunction
nmap <Leader>f :call SyncTexForward()<CR>

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

vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

nnoremap <silent> ,q :q<CR>
map  ,, <C-^>
map <C-n> :lprevious<CR>
map <C-m> :lnext<CR>
nnoremap ü :YcmCompleter GoToDefinitionElseDeclaration<CR>

command W w
command Wq wq

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<C-j>"
let g:UltiSnipsJumpForwardTrigger = "<C-j>"

let g:ycm_filetype_whitelist = { 'cpp': 1, 'h':1,  'py':1 }
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
