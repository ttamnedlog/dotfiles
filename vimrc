set nocompatible " iMproved

" Vim Plug {{{
" Install Vim Plug if it's not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" NOTE: cmake is required to compile the YouCompleteMe plugin below!

call plug#begin('~/.vim/bundle')
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'dense-analysis/ale'
Plug 'easymotion/vim-easymotion'
Plug 'editorconfig/editorconfig-vim'
Plug 'godlygeek/tabular'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'mileszs/ack.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'preservim/tagbar'
Plug 'preservim/vim-indent-guides'
Plug 'raimondi/delimitmate'
Plug 'rakr/vim-one'
" Plug 'altercation/vim-colors-solarized'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'sjl/gundo.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
" Plug 'valloric/youcompleteme', { 'do': './install.py' }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-vdebug/vdebug'
" Language plugins
Plug 'sheerun/vim-polyglot'
call plug#end()
" }}}

" General settings {{{
" Different cursors for different modes
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

set backupdir=$TMPDIR//             " Make backups in OS's temp directory
set cursorline                      " Highlight line cursor is on
set directory=$TMPDIR//             " Make .swp files in OS's temp directory
set hidden                          " Allow buffers to be switched before saving
set hlsearch                        " Highlight search results
set lazyredraw                      " Don't redraw screen during macros
set listchars=tab:»\ ,trail:·,eol:¬ " Determine invisible characters
set mouse=a                         " Enable mouse
set relativenumber number           " Line numbering
set showcmd                         " Displays current command in bottom right
set splitbelow splitright           " Open new split panes to right and bottom
set regexpengine=1                  " Use new regexpengine for improved performance

" Persistent undo
set undodir=$HOME/.vim/undo
set undofile
set undolevels=1000
set undoreload=10000
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

syntax enable
let g:airline_theme='one'
set background=dark
colorscheme one
" let g:airline_theme='solarized'
" set background=light
" colorscheme solarized
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

" Map escape to jk
inoremap jk <esc>

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
" }}}

" --- Ack {{{
" Use The Silver Searcher instead of Ack
let g:ackprg = 'ag --vimgrep'
"  }}}

" --- Airline {{{
" let g:airline#extensions#tagbar#enabled = 0
" }}}

" --- CtrlP {{{
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" Use The Silver Searcher for faster searches
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" }}}

" --- EditorConfig {{{
let g:EditorConfig_exclude_patterns = ['fugitive://.*', '.diff']
" }}}

" --- GUndo {{{
let g:gundo_prefer_python3 = 1
" }}}

" --- IndentGuides {{{
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2c323c
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#282c34
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
