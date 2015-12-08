set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'flazz/vim-colorschemes'

Plug 'kien/ctrlp.vim'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'bling/vim-airline'

Plug 'justinmk/vim-syntax-extra'
Plug 'tpope/vim-markdown'
Plug 'fatih/vim-go'
Plug 'kchmck/vim-coffee-script'
Plug 'rust-lang/rust.vim'
call plug#end()

set guioptions=gmtr
set number
set statusline=%<%f\ %h%m%r%=%-20.(line=%l,col=%c%V,totlin=%L%)\%h%m%r%=%-40(,bytval=0x%B,%n%Y%)\%P
set wildignore=*.o,*.obj,*.bak,*.exe,*.pyc,*.DS_Store,*.db
set nobackup
set noswapfile

map ,v :sp ~/.vimrc<cr> " edit my .vimrc file in a split
map ,e :e ~/.vimrc<cr>      " edit my .vimrc file
map ,u :source ~/.vimrc<cr> " update the system settings from my vimrc file

nnoremap ,r :%s/\<<C-r><C-w>\>//g<Left><Left>

let g:ctrlp_lazy_update = 150
let g:ctrlp_split_window = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_persistent_input = 0
let g:ctrlp_match_window_reversed = 0

nnoremap <Leader>t :CtrlP<cr>
nnoremap <Leader>e :CtrlPBuffer<cr>

set t_Co=256
colorscheme jellybeans

autocmd FileType sh,python,markdown setlocal expandtab autoindent
autocmd FileType html,ruby,javascript,coffee,lua setlocal expandtab autoindent tabstop=2 shiftwidth=2 softtabstop=2 

autocmd QuickFixCmdPost *grep* cwindow

set tabstop=4
set shiftwidth=4
set softtabstop=4
