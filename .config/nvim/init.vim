let mapleader = " "
let g:python3_host_prog = "/usr/bin/python"
syntax enable
filetype plugin indent on

set encoding=UTF-8
set noswapfile
set scrolloff=10
set backspace=indent,eol,start
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set noerrorbells
set modeline
set smartindent
set nu
set wrap linebreak
set smartcase
set undofile
set incsearch
set showcmd
set ruler
set textwidth=80 colorcolumn=80
set laststatus=2
set clipboard+=unnamedplus
set undodir=~/.config/nvim/undodir
set fileformat=unix
set runtimepath+=/usr/share/vim/vimfiles
set viminfo+=n~/.config/nvim/viminfo
set rtp+=~/.config/nvim
set modifiable

" Split
set splitbelow
map <C-j> <C-w>j
map <C-k> <C-w>k
" Buffer
nmap <C-h> :bp<CR>
nmap <C-l> :bn<CR>
nmap <C-c> :bd<CR>


call plug#begin('~/.config/nvim/plugged')

" Customizations
Plug 'morhetz/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'yuttie/comfortable-motion.vim'
Plug 'mengelbrecht/lightline-bufferline'

" IDE stuff
Plug 'luochen1990/rainbow'
Plug 'tpope/vim-surround'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'preservim/nerdtree'
Plug 'zchee/deoplete-jedi'
Plug 'Townk/vim-autoclose'
Plug 'jiangmiao/auto-pairs'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'chiel92/vim-autoformat'

Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Language-specific
Plug 'lervag/vimtex'
Plug 'hdima/python-syntax'
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'Vimjas/vim-python-pep8-indent'

call plug#end()

" Colors
colorscheme gruvbox
set background=dark
if (has("termguicolors"))
    set termguicolors
endif
lua require 'colorizer'.setup()
let g:rainbow_active = 1

" Lightline
let g:lightline = {
            \ 'colorscheme': 'one',
            \ 'active': {
            \   'left': [['mode', 'paste'], ["buffers"]]},
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ }
            \ }
autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#enable_nerdfont=1

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let NERDTreeQuitOnOpen=1
let g:NERDTreeMinimalUI=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
set ma

" Smooth scroll
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
let g:comfortable_motion_friction = 1.0
let g:comfortable_motion_air_drag = 4.0

" Python stuff
let python_highlight_all = 1
noremap <S-f> :Autoformat<CR>
let g:formatdef_autopep8 = "black -l 80"
let g:formatters_python = ['black']
let g:loaded_python_provider = 0
let g:jedi#use_tabs_not_buffers = 1
let g:jedi#show_call_signatures = "1"
let g:jedi#max_doc_height=50
let g:jedi#popup_on_dot = 0
let g:jedi#smart_auto_mappings=1

" Completion
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<C-Space>" :
"      \ deoplete#manual_complete()

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_compiler_engine = 'lualatex'
let g:LatexBox_latexmk_async=1
let g:LatexBox_latexmk_preview_continuously=1

" Snippets
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["my-snippets"]


" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using lua functions
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
