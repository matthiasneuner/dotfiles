if $TERM == "xterm-256color"
    set t_Co=256
endif

if &term =~ '256color'
    set t_ut=
endif

set nocompatible              

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'psliwka/vim-smoothie'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets' 
Plug 'tpope/vim-commentary'
Plug 'justinmk/vim-dirvish'
Plug 'vim-scripts/visual-increment'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'jnurmine/Zenburn'
Plug 'morhetz/gruvbox'
Plug 'cocopon/iceberg.vim'
Plug 'lervag/vimtex'
Plug 'KeitaNakamura/tex-conceal.vim'   
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

filetype plugin indent on    
syntax enable
colorscheme zenburn
let g:gruvbox_contrast_dark='soft'
" colorscheme gruvbox 
set bg=dark
set lbr
set number
set ts=4
set autoindent
set expandtab
set shiftwidth=4
set laststatus=2
set statusline+=%F
set hidden
set noshowmatch
set conceallevel=1
set foldmethod=marker

" key maps {{{
nnoremap <silent> ,q :q<CR>
map  ,, <C-^>

command W w
command Wq wq
" }}}

" clipboard {{{
set clipboard+=unnamedplus
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
" }}}
"
" UltiSnips {{{
let g:UltiSnipsExpandTrigger = "<nop>"          " disable due to clash with CoC
let g:UltiSnipsJumpForwardTrigger = "<nop>"     " -,,- 
let g:UltiSnipsListSnippets = "<C-Space>"
"}}}

" Vimtex & conceal {{{
let g:tex_flavor='latex'
let g:tex_conceal='abdmg'
let g:vimtex_quickfix_mode=0
let g:vimtex_complete_close_braces=1            " otherwise more or less useless
let g:vimtex_matchparen_enabled=0               " don't be sluggish!
let g:vimtex_view_method = 'zathura'

" }}}

" ctrlP {{{
let g:ctrlp_cmd = 'CtrlPBuffer'
" }}}

" Abaqus {{{
function RemoveAbaqusINPStuff()
    :%s/generate/generate=True/g
    :%s/instance=Part-1-1,//g
    :%s/instance=Part-1-1//g
endfunction
" }}}

" Coc Setup {{{
let g:coc_global_extensions=['coc-vimtex', 'coc-clangd', 'coc-cmake']

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
" set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes


" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <C-j> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" modified by me: if Coc failed, it tries to expand a snippet using ultisnips
snoremap <silent> <C-j>  <Esc>:call UltiSnips#ExpandSnippetOrJump()<cr>
if exists('*complete_info')
    " inoremap <expr> <C-j> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    inoremap <expr> <C-j> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"
else
    " imap <expr> <C-j> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    imap <expr> <C-j> pumvisible() ? "\<C-y>" : "\<C-R>=UltiSnips#ExpandSnippetOrJump()<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for selections ranges.
" NOTE: Requires 'textDocument/selectionRange' support from the language server.
" coc-tsserver, coc-python are the examples of servers that support it.
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" nnoremap <silent> <TAB>  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" }}}
