set nocompatible " be iMproved, required

call plug#begin('~/.vim/plugged')
  " UI & theme
  Plug 'arcticicestudio/nord-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'mhinz/vim-startify'
  Plug 'Yggdroot/indentLine'
  Plug 'RRethy/vim-illuminate'
  Plug 'machakann/vim-highlightedyank'
  Plug 'airblade/vim-gitgutter'
  Plug 'liuchengxu/vista.vim'
  " editing
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-commentary'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'junegunn/goyo.vim'
  " utility
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'rhysd/git-messenger.vim'
  Plug 'voldikss/vim-floaterm'
  Plug 'christoomey/vim-system-copy'
  " language
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'nathangrigg/vim-beancount'
  Plug 'ap/vim-css-color'
  Plug 'mattn/emmet-vim'
call plug#end()
noremap <leader>pi :PlugInstall<cr>
noremap <leader>pc :PlugClean<cr>

filetype plugin indent on
syntax enable

set exrc
set nobackup
set noswapfile
set expandtab
set ts=4
set sw=4
if !has('gui_running')
  set t_Co=256
endif
set background=dark
set number
set cursorline
set ruler
set noignorecase
set autoindent
set whichwrap=b,s,<,>,[,]
set backspace=2
set encoding=utf-8
set list
set hlsearch
set noincsearch
set completeopt-=preview
set guitablabel=%t
set hidden
set cmdheight=2
set updatetime=300
set shortmess+=c
set signcolumn=yes
set mousehide
set showmatch
set undodir=~/.vim/undodir
set undofile
set wildmenu
set wildmode=longest,full
colorscheme nord

" Shortcuts
nnoremap <leader>r :source ~/.config/nvim/init.vim<cr>
noremap <leader># :let @/ = ""<cr><esc>
noremap <leader>] gt<cr>
noremap <leader>[ gT<cr>
noremap <leader>q :q!<cr>
noremap <leader>e :e!<cr>
noremap <leader>Q :qa!<cr>
noremap <leader>w :wq!<cr>
noremap <leader>n :set nonu<cr>
noremap <leader>N :set number<cr>
noremap <leader>R :set relativenumber<cr>
noremap <leader>s <c-w>w
noremap <c-j> <c-w>j
noremap <c-k> <c-w>k
noremap <c-h> <c-w>h
noremap <c-l> <c-w>l
noremap <leader>t[ :tabmove -1<cr>
noremap <leader>t] :tabmove +1<cr>
inoremap <c-d> <esc>ddi
nnoremap <A-Up> :m .-2<CR>
nnoremap <A-Down> :m .+1<CR>

function! TrimWhitespace()
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction

augroup trim_whitespace
  autocmd!
  autocmd BufWritePre * :call TrimWhitespace()
augroup END

" Indent/tabs
augroup filetype_options
  autocmd Filetype vim  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype go   setlocal ts=4 sts=4 sw=4 noexpandtab
  autocmd Filetype css  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype scss setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype html setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype yml  setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype yaml setlocal ts=2 sts=2 sw=2 expandtab
  autocmd Filetype beancount setlocal nofoldenable relativenumber
augroup END

" Plugins
""" FZF
let g:fzf_action = {
  \ 'ctrl-q': 'wall | bdelete',
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_layout = { 'left': '~25%' }
let g:fzf_preview_window = ['up:40%:hidden', 'ctrl-p']
nnoremap <leader>fh :History<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>ff :Files<CR>

""" vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_metalinter_autosave = 1
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck']
let g:go_format_autosave = 1
let g:go_fmt_command = "goimports"

""" Emmet
let g:user_emmet_install_global = 0
let g:user_emmet_leader_key='<C-E>'
autocmd FileType html,css EmmetInstall

""" Goyo
nnoremap <leader>go :Goyo<CR>
let g:goyo_width = 120

function! s:goyo_enter()
  set noshowmode
  set noshowcmd
endfunction

function! s:goyo_leave()
  set showmode
  set showcmd
endfunction

""" CoC
" Ref: <https://github.com/neoclide/coc.nvim#example-vim-configuration>
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

augroup coc
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Vista
nnoremap <leader>va :Vista<CR>
let g:vista_sidebar_width = 60
let g:vista_echo_cursor = 0
let g:vista_default_executive = 'coc'
let g:vista#executives = ['coc']
let g:vista_icon_indent = ["* ", "-> "]
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "f",
\   "variable": "v",
\   "constant": "c",
\   "method": "m",
\  }

" Floaterm
nnoremap <leader>fn :FloatermNew<CR>
let g:floaterm_height = 0.4
let g:floaterm_width = 0.5
let g:floaterm_position = 'topright'
let g:floaterm_autoclose = 1

" Git Messenger
nnoremap <leader>gm :GitMessenger<CR>
