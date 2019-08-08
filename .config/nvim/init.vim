"----------------------------------------------
" Plugin management
"
" Download vim-plug from the URL below and follow the installation
" instructions:
" https://github.com/junegunn/vim-plug
"----------------------------------------------
call plug#begin('~/.vim/plugged')

" Dependencies
Plug 'godlygeek/tabular'           " This must come before plasticboy/vim-markdown
Plug 'tpope/vim-rhubarb'           " Depenency for tpope/fugitive

" General plugins
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'bling/vim-airline'
Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'tmhedberg/SimpylFold'
Plug 'Yggdroot/indentLine'
Plug 'jpalardy/vim-slime'
Plug 'ludovicchabant/vim-gutentags' " Need to install universal ctags
Plug 'mileszs/ack.vim'              " Install ag to speed up next two plugins
Plug 'ctrlpvim/ctrlp.vim'

" Language support
Plug 'lifepillar/pgsql.vim'
Plug 'plasticboy/vim-markdown'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }

" Colorschemes
Plug 'sjl/badwolf'

call plug#end()

"----------------------------------------------
" General settings
"----------------------------------------------
set autoindent                    " take indent for new line from previous line
set smartindent                   " enable smart indentation
set autoread                      " reload file if the file changes on the disk
set autowrite                     " write when switching buffers
set autowriteall                  " write on :quit
set clipboard=unnamedplus
set completeopt-=preview          " remove the horrendous preview window
set cursorline                    " highlight the current line for the cursor
set encoding=utf-8
set expandtab                     " expands tabs to spaces
set list                          " show trailing whitespace
set listchars=tab:\|\ ,trail:▫
set nospell                       " disable spelling
set noswapfile                    " disable swapfile usage
set noerrorbells                  " No bells!
set novisualbell                  " I said, no bells!
set number                        " show number ruler
set lazyredraw
set hidden
set ruler
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=80
set title                         " let vim set the terminal title
set updatetime=100                " redraw the status bar often

" neovim specific settings
if has('nvim')
    " Set the Python binaries neovim is using. Please note that you will need to
    " install the neovim package for these binaries separately like this for
    " example:
    " pip install -U neovim
    let g:python_host_prog = '/home/ubudgie/miniconda3/envs/nvim2/bin/python'
    let g:python3_host_prog = '/home/ubudgie/miniconda3/envs/nvim3/bin/python'
endif

" Enable mouse if possible
if has('mouse')
    set mouse=a
endif

" Allow vim to set a custom font or color for a word
syntax enable

" Set the leader button
let mapleader = ','

" Autosave buffers before leaving them
autocmd BufLeave * silent! :wa

" Remove trailing white spaces on save
autocmd BufWritePre * :%s/\s\+$//e

" Center the screen quickly
nnoremap <space> zz

" Remap Escape key
inoremap jk <Esc>

"----------------------------------------------
" Colors
"----------------------------------------------
set background=dark
colorscheme badwolf

" Override the search highlight color with a combination that is easier to
" read. The default PaperColor is dark green backgroun with black foreground.
"
" Reference:
" - http://vim.wikia.com/wiki/Xterm256_color_names_for_console_Vim
" highlight Search guibg=DeepPink4 guifg=White ctermbg=53 ctermfg=White

" Toggle background with <leader>bg
map <leader>bg :let &background = (&background == "dark"? "light" : "dark")<cr>

"----------------------------------------------
" Searching
"----------------------------------------------
set incsearch                     " move to match as you type the search query
set hlsearch                      " disable search result highlighting

if has('nvim')
    set inccommand=split          " enables interactive search and replace
endif

" Clear search highlights
map <leader>c :nohlsearch<cr>

" These mappings will make it so that going to the next one in a search will
" center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"----------------------------------------------
" Navigation
"----------------------------------------------
" Move between buffers with Shift + arrow key...
nnoremap <S-H> :bprevious<cr>
nnoremap <S-L> :bnext<cr>

" ... but skip the quickfix when navigating
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
augroup END

" Fix some common typos
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"----------------------------------------------
" Splits
"----------------------------------------------
" Create horizontal splits below the current window
set splitbelow
set splitright

" Creating splits
nnoremap <leader>v :vsplit<cr>
nnoremap <leader>h :split<cr>

" Closing splits
nnoremap <leader>q :close<cr>

"split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>



"----------------------------------------------
" Plugin: Shougo/deoplete.nvim
"----------------------------------------------
if has('nvim')
    " Enable deoplete on startup
    let g:deoplete#enable_at_startup = 1
endif

" Disable deoplete when in multi cursor mode
function! Multiple_cursors_before()
    let b:deoplete_disable_auto_complete = 1
endfunction

function! Multiple_cursors_after()
    let b:deoplete_disable_auto_complete = 0
endfunction

let g:deoplete#auto_completion_start_length = 1
set omnifunc=jedi#completions
let g:jedi#auto_initialization = 1

"let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})

"----------------------------------------------
" Plugin: bling/vim-airline
"----------------------------------------------
" Show status bar by default.
set laststatus=2

" Enable top tabline.
let g:airline#extensions#tabline#enabled = 1

" Enable ale
let g:airline#extensions#ale#enabled = 1

" Disable showing tabs in the tabline. This will ensure that the buffers are
" what is shown in the tabline at all times.
let g:airline#extensions#tabline#show_tabs = 0

" Enable powerline fonts.
let g:airline_powerline_fonts = 0

" Explicitly define some symbols that did not work well for me in Linux.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.branch = ''
let g:airline_symbols.maxlinenr = ''


"----------------------------------------------
" Plugin: ctrlpvim/ctrlp.vim
"----------------------------------------------
if executable('rg')
  let g:ctrlp_user_command = 'rg %s -l --nocolor -g ""'
elseif executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" rg/ag is fast enough that CtrlP doesn't need to cache
let g:ctrlp_use_caching = 0

"----------------------------------------------
" Plugin: mileszs/ack.vim
"----------------------------------------------
if executable('rg')
    let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif


"----------------------------------------------
" Plugin: plasticboy/vim-markdown
"----------------------------------------------
" Disable folding
let g:vim_markdown_folding_disabled = 1

" Auto shrink the TOC, so that it won't take up 50% of the screen
let g:vim_markdown_toc_autofit = 1

" Disable concealing of links
let g:vim_markdown_conceal = 0

"----------------------------------------------
" Plugin: scrooloose/nerdtree
"----------------------------------------------
nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <F2> :NERDTreeToggle<cr>

" Files to ignore
let NERDTreeIgnore = [
    \ '\~$',
    \ '\.pyc$',
    \ '^\.DS_Store$',
    \ '^node_modules$',
    \ '^.ropeproject$',
    \ '^__pycache__$'
\]

" Close vim if NERDTree is the only opened window.
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Show hidden files by default.
let NERDTreeShowHidden = 1

" Allow NERDTree to change session root.
let g:NERDTreeChDirMode = 2

" Set size to display
let g:NERDTreeWinSize=20

" nerdtree-tabs
let g:nerdtree_tabs_open_on_console_startup=1

" Closes NERDTree after opening a file
let NERDTreeQuitOnOpen=1

"----------------------------------------------
" Plugin: tmhedberg/SimpylFold
"----------------------------------------------
" Enable folding
set foldmethod=indent
set foldlevel=99
" Enable folding with the spacebar
nnoremap <space> za

let g:SimpylFold_docstring_preview=1


"----------------------------------------------
" Plugin: jpalardy/vim-slime
"----------------------------------------------
let g:slime_target = "tmux"

"----------------------------------------------
" Plugin: Yggdroot/indentLine'
"----------------------------------------------
let g:indentLine_fileTypeExclude = ['markdown']

"----------------------------------------------
" Language: Make
"----------------------------------------------
au FileType make set noexpandtab
au FileType make set shiftwidth=2
au FileType make set softtabstop=2
au FileType make set tabstop=2

"----------------------------------------------
" Language: Markdown
"----------------------------------------------
au FileType markdown setlocal spell
au FileType markdown setlocal conceallevel=0
au FileType markdown set syntax=markdown
