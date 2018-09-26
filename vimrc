" Python deprecation warning TEMPORARY workaround {{{
if has('python3')
  silent! python3 1
endif
" }}}

set nocompatible " iMproved

" Vim Plug {{{
" Install Vim Plug if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'mileszs/ack.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'w0rp/ale'
" Plug 'jwalton512/vim-blade'
Plug 'tpope/vim-commentary'
Plug 'kien/ctrlp.vim'
Plug 'raimondi/delimitmate'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sjl/gundo.vim'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'terryma/vim-multiple-cursors'
" Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
" Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'godlygeek/tabular'
" Plug 'majutsushi/tagbar'
" Plug 'vim-vdebug/vdebug'
Plug 'tpope/vim-vinegar'
" Plug 'valloric/youcompleteme', { 'do': './install.py' }
call plug#end()
" }}}

" General settings {{{
" Different cursors for different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

" set backupdir=$TMPDIR//             " Make backups in OS's temp directory
set cursorline                      " Highlight line cursor is on
" set directory=$TMPDIR//             " Make .swp files in OS's temp directory
set hidden                          " Allow buffers to be switched before saving
set hlsearch                        " Highlight search results
set lazyredraw                      " Don't redraw screen during macros
set listchars=tab:»\ ,trail:·,eol:¬ " Determine invisible characters
" set mouse=a                         " Enable mouse
set relativenumber number           " Line numbering
set showcmd                         " Displays current command in bottom right
set splitbelow splitright           " Open new split panes to right and bottom
set regexpengine=1                  " Use new regexpengine for improved performance

" Persistent undo
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000

" set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
"              | | | | |  |   |      |  |     |    |
"              | | | | |  |   |      |  |     |    +-- current column
"              | | | | |  |   |      |  |     +-- current line
"              | | | | |  |   |      |  +-- current % into file
"              | | | | |  |   |      +-- current syntax
"              | | | | |  |   +-- current fileformat
"              | | | | |  +-- number of lines
"              | | | | +-- preview flag in square brackets
"              | | | +-- help flag in square brackets
"              | | +-- readonly flag in square brackets
"              | +-- modified flag in square brackets
"              +-- full path to file in the buffer
" }}}

" Colors {{{
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" let g:airline_theme='onedark'
" let g:airline_theme='solarized'
" let g:airline_theme='one'
let g:airline_theme='papercolor'
" colorscheme onedark
" colorscheme solarized
" colorscheme one
colorscheme PaperColor
set background=light
" }}}

" Keybindings {{{
" edit and source .vimrc
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source % <bar> :AirlineRefresh<CR>

" <space> folds and unfolds
nnoremap <space> za

nnoremap <leader>u :GundoToggle<CR>

" Force saving files that require root permission
cnoremap w!! w !sudo tee > /dev/null %
" }}}

" --- Ack {{{
" Use The Silver Searcher instead of Ack
" let g:ackprg = 'ag --vimgrep'
"  }}}

" --- Airline {{{
" let g:airline#extensions#tagbar#enabled = 0
" }}}

" --- CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" Use The Silver Searcher for faster searches
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" }}}

" --- EditorConfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', '.diff']
" }}}

" --- IndentGuides {{{
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2e3138
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#393d46
" }}}

" --- Polyglot {{{
" Define some single Blade directives. This variable is used for highlighting only.
let g:blade_custom_directives = ['debug', 'dump']
" }}}

" --- Xdebug {{{
" Source file for XDebug path maps
if !empty(glob('~/.xdebug-maps'))
  so ~/.xdebug-maps
endif
" }}}

" vim:foldmethod=marker:foldlevel=0
