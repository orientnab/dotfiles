  if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  endif

  autocmd BufNewFile,BufRead *.ron setf ron
  autocmd BufNewFile,BufRead *.lark setf lark

  call plug#begin()
    Plug 'morhetz/gruvbox'
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer --rust-completer' }
    " Plug 'ycm-core/YouCompleteMe', { 'do': './install.py --clangd-completer' }
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'junegunn/fzf'
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-unimpaired'     " Some useful mappings in vim [e, [<space>, [b, [u, [x, etc
    Plug 'tpope/vim-surround'       " Mappings to create/del/mod surrounding brackets
    Plug 'tpope/vim-abolish'        " Comment/uncomment stuff
    Plug 'tpope/vim-commentary'     " Comment/uncomment stuff
    Plug 'tpope/vim-dispatch'       " Async make
    Plug 'tpope/vim-fugitive'       " Git in vim
    Plug 'airblade/vim-gitgutter'   " Icons showing added/deleted/modified lines from git
    " Plug 'tpope/vim-abolish'        " auto spellchecker, universal replacing and variable case change
    Plug 'tpope/vim-repeat'         " Repeat using . also valid for non native commands
    Plug 'junegunn/vim-easy-align'  " Plugin alignment
    Plug 'christoomey/vim-tmux-navigator' " Seamless navigation between tmux and vim
    Plug 'vim-syntastic/syntastic'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'majutsushi/tagbar'
    Plug 'jszakmeister/markdown2ctags'
    Plug 'junegunn/goyo.vim'
    " Snippets (engine)
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'       " Database with the actual snippets
    " Filetypes
    Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
    Plug 'vim-pandoc/vim-pandoc', { 'for': ['pandoc', 'markdown'] }
    Plug 'vim-pandoc/vim-pandoc-syntax', { 'for': ['pandoc', 'markdown'] }
    " Plug 'python-mode/python-mode', { 'for': 'python' }
    Plug 'rust-lang/rust.vim'
    Plug 'cespare/vim-toml', { 'for': 'toml' }
    Plug 'ron-rs/ron.vim', { 'for': 'ron' }
    " Plug 'ycm-core/lsp-examples', { 'do': './install.py --enable-rust' }
    Plug 'lark-parser/vim-lark-syntax', { 'for': 'lark' }
    " Code Formatting
    Plug 'google/vim-maktaba'
    Plug 'google/vim-codefmt'
    Plug 'google/vim-glaive'
  call plug#end()
  call glaive#Install()
  Glaive codefmt clang_format_style='file'

  let mapleader=","

  set hidden
  set autowrite
  set autoread
  set encoding=utf-8
  if &history < 1000
    set history=1000
  endif

  " filetype plugin indent on

" Vimdiff
  if &diff
    " Ignore whitespace
    set diffopt+=iwhite
  endif

" Colors and colorschemes
  if has('syntax') && !exists('g:syntax_on')
    syntax enable
  endif

  colorscheme gruvbox
  set background=dark
  highlight Normal ctermbg=NONE
  highlight GitGutterAdd ctermfg=Green
  highlight GitGutterChange ctermfg=Yellow
  highlight GitGutterDelete ctermfg=Red

  set colorcolumn=81
  highlight ColorColumn ctermbg=237

" Windows/panes/tmux moves
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>
  set splitbelow
  set splitright

" Whitespace and indentation
  set tabstop=4           " 2 space tab
  set expandtab           " use spaces for tabs
  set softtabstop=4       " 2 space tab
  set shiftwidth=4        " space when using >> and <<
  set smarttab            " uses shiftwidth when using tab at the beggining of lines
  set autoindent
  set backspace=indent,eol,start

  function! StripTrailingWhitespace() " Remove trailing whitespace on save
    " Save cursor position
    let l:save = winsaveview()
    " Remove trailing whitespace
    %s/\s\+$//e
    " Move cursor to original position
    call winrestview(l:save)
  endfunction
  autocmd BufWritePre * call StripTrailingWhitespace()

" UI Layout
  set number              " show line numbers
  set relativenumber      " show line numbers
  set showcmd             " show command in bottom bar
  set cursorline          " highlight current line
  set showmatch           " highlight matching [{()}]
  set wildmenu            " visual autocomplete for command menu
  set wildignore=*.swp,*.aux,*.blg,*.bst
  set wildignorecase
  set lazyredraw          " redraw only when we need to

  set linebreak	          " visually break long lines
  set display+=lastline   " As much as possible of the last line is displayed
  set statusline=2        " (2) always show status line
  set ruler               " Display line and column in the statusline
  if !&scrolloff
    set scrolloff=2
  endif
  if !&sidescrolloff
    set sidescrolloff=5
  endif

  " Map mouse wheel to scroll
  nmap <Down> <C-e>
  nmap <Up> <C-y>

  set modelines=1         " Reads the commented line at the end of the file (default=5)

" Directory explorer
  nmap <silent> <Leader>n :Explore <CR>
  let g:netrw_banner = 0
  let g:netrw_liststyle = 3
  " let g:netrw_browse_split = 4
  " let g:netrw_altv = 1
  " let g:netrw_winsize = 25

" Airline
  let g:airline_theme='gruvbox'
  " set statusline=%f "tail of the filename
  " set statusline+=\ c:%c
  if !exists('g:airline_symbols')
    let g:airline_symbols={}
  endif
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
  let g:airline_symbols.maxlinenr = ''
  let g:airline_symbols.dirty='⚡'

  let g:airline_right_sep=''
  let g:airline_left_sep=''
  let g:airline_right_alt_sep=''
  let g:airline_left_alt_sep=''
  let g:airline_section_z = '%#__accent_bold#%4l/%L%#__restore__# :%3v'

" Searching
  set incsearch           " search as characters are entered
  set hlsearch            " highlight matches
  set ignorecase
  set smartcase
  set infercase
  nnoremap <leader><space> :nohlsearch \| cclose \| lclose <CR>

" Comments
  autocmd FileType cpp setlocal commentstring=//\ %s
  autocmd BufRead,BufNewFile *.h setlocal commentstring=/*%s*/

" Folding
  set foldenable          " enable folding
  set foldmethod=indent   " fold based on indent level (for other methods :help foldmethod)
  set foldnestmax=10      " 10 nested fold max
  " set foldcolumn=2        " making some room for folding characters in the gutter
  set foldlevelstart=10   " open most folds by default

" Spelling
  autocmd FileType tex,markdown,pandoc setlocal spell spelllang=en_gb
  autocmd FileType tex,markdown,pandoc setlocal breakindent
  autocmd FileType tex,markdown,pandoc highlight pandocReferenceDefinition ctermfg=Blue
  autocmd FileType tex,markdown,pandoc highlight pandocStrong ctermfg=Yellow cterm=none
  autocmd FileType tex,markdown,pandoc highlight SpellBad cterm=underline
  autocmd FileType tex,markdown,pandoc highlight SpellCap cterm=underline
  autocmd FileType tex,markdown,pandoc highlight SpellLocal cterm=underline
  autocmd FileType tex,markdown,pandoc highlight SpellRare cterm=underline
  autocmd FileType tex,markdown,pandoc highlight SpellRare cterm=underline

  autocmd FileType tex,markdown,pandoc Abolish teh the

" YouCompleteMe
  let g:ycm_confirm_extra_conf = 0      " Not asking for .ycm_extra_conf.py on start
  let g:ycm_global_ycm_extra_conf = '~/projects/.ycm_extra_conf.py'
  nmap <silent> <Leader>x :YcmCompleter FixIt<CR>
  nmap <leader>gt  :YcmCompleter GoToDefinition<CR>
  nmap <leader>gd  :YcmCompleter GoToDefinition<CR>
  nmap <leader>ge  :YcmShowDetailedDiagnostic<CR>
  " let g:ycm_key_list_stop_completion = ['<C-y>', '<CR>']
  let g:ycm_key_list_stop_completion = ['<C-y>']
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>', '<tab>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  let g:ycm_autoclose_preview_window_after_completion=1
  let g:ycm_rust_src_path = '/home/nabs/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/lib/rustlib/src/rust/src/'
  " let g:ycm_language_server =
  "       \ [
  "       \   {
  "       \     'name': 'rust',
  "       \     'cmdline': ['rust-analyzer'],
  "       \     'filetypes': ['rust'],
  "       \     'project_root_files': ['Cargo.toml']
  "       \   }
  "       \ ]
  " source /home/nabs/.vim/plugged/lsp-examples/vimrc.generated

" UltiSnips
  " let g:UltiSnipsExpandTrigger="<c-b>"
  let g:UltiSnipsExpandTrigger='<c-b>'
  let g:UltiSnipsJumpForwardTrigger='<c-b>'

" FZF
  let g:fzf_layout = { 'down': '~50%' }
  function! s:find_git_root()
    return system('git rev-parse --show-toplevel 2> /dev/null')[:-2]
  endfunction
  command! ProjectFiles execute 'Files' s:find_git_root()
  " nnoremap <silent> <Leader>f :FZF<CR>
  nnoremap <silent> <Leader>f :ProjectFiles<CR>
  nnoremap <silent> <Leader>b :Buffers<CR>
  nnoremap <silent> <Leader>rg :Rg<CR>
  nmap <leader><tab> <plug>(fzf-maps-n)
  xmap <leader><tab> <plug>(fzf-maps-x)
  omap <leader><tab> <plug>(fzf-maps-o)
  imap <c-x><c-k> <plug>(fzf-complete-word)
  inoremap <expr> <c-x><c-f> fzf#vim#complete#path('rg --files')
  imap <c-x><c-l> <plug>(fzf-complete-line)
  if executable('rg')
    let g:rg_derive_root='true'
  endif

" Easy-align
  xmap ga <Plug>(EasyAlign)
  nmap ga <Plug>(EasyAlign)

" Make shortcuts
  nmap <F6> :w \| execute 'silent !tmux send-keys -t bottom make Enter' \| redraw! <cr>
  imap <F6> <Esc>:w \| execute 'silent !tmux send-keys -t bottom make Enter' \| redraw! <cr>

" Version Control
  let g:gitgutter_enabled = 1
  let g:gitgutter_map_keys = 0

" Syntastic settings
  " set statusline+=%#warningmsg#
  " set statusline+=%{SyntasticStatuslineFlag()}
  " set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1  " :h syntastic-error-window
  let g:syntastic_auto_loc_list = 1             " Automatically open/close location-list [0-3]
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 1
  let g:syntastic_loc_list_height = 5
  " let g:syntastic_error_symbol = "\u2717"
  " let g:syntastic_warning_symbol = "\u26A0"
  noremap <silent> <Leader>w :SyntasticToggleMode <cr>

" Tagbar
  let g:tagbar_width=50
  let g:tagbar_autofocus = 1
  let g:tagbar_autoclose=1
  let g:tagbar_show_linenumbers=1
  noremap <silent> <Leader>t :TagbarToggle <cr>

" Filetypes: Latex
  let g:tagbar_type_tex = {
    \ 'ctagstype' : 'latex',
    \ 'kinds'     : [
        \ 's:sections',
        \ 'g:graphics:0:0',
        \ 'l:labels',
        \ 'r:refs:1:0',
        \ 'p:pagerefs:1:0'
    \ ],
    \ 'sort': 0,
  \ }

" Filetypes: Markdown
  let g:pandoc#keyboard#display_motions = 0     " Disable j to gj and k to gk bindings
  let g:pandoc#folding#fdc = 0                 " Remove foldcolum
  let g:tex_flavor='latex'
  set conceallevel=2
  let g:tex_conceal='admgs'
  let g:pandoc#syntax#conceal#urls=1            " to conceal urls

  let g:tagbar_type_pandoc = {
      \ 'ctagstype': 'pandoc',
      \ 'ctagsbin' : '~/.vim/plugged/markdown2ctags/markdown2ctags.py',
      \ 'ctagsargs' : '-f - --sort=yes --sro=»',
      \ 'kinds' : [
          \ 's:sections',
          \ 'i:images'
      \ ],
      \ 'sro' : '»',
      \ 'kind2scope' : {
          \ 's' : 'section',
      \ },
      \ 'sort': 0,
  \ }

" Filetypes: C/C++
  " Reformat file
  function! Reformat()
    " Save cursor position
    let l:save = winsaveview()
    " Call astyle on the current buffer
    %!astyle -s4 -xw -xW -w --style=google
    " Move cursor to original position
    call winrestview(l:save)
  endfunction

  " augroup reformat
  "   autocmd!
  "   autocmd FileType c,cpp nmap <silent> <Leader>a :call Reformat()<CR>
  "   autocmd FileType rust nmap <silent> <Leader>a :RustFmt<CR>
  " augroup end
  nmap <silent> <Leader>a :FormatCode<CR>
  nmap <silent> <Leader>A :FormatLines<CR>

" Filetypes: Makefile
  autocmd FileType make set noexpandtab

" Filetypes: Python
  " let g:SimpylFold_docstring_preview=1
  autocmd FileType python highlight BadWhitespace cterm=reverse,underline ctermfg=1
  autocmd BufRead,BufNewFile *.py,*.pyw match BadWhitespace /\s\+$/

" Filetypes: Rust
  let g:rust_use_custom_ctags_defs = 1  " if using rust.vim
  let g:tagbar_type_rust = {
    \ 'ctagsbin' : '/home/nabs/aur/universal-ctags-git/pkg/universal-ctags-git/usr/bin/ctags',
    \ 'ctagstype' : 'rust',
    \ 'kinds' : [
        \ 'n:modules',
        \ 's:structures:1',
        \ 'i:interfaces',
        \ 'c:implementations',
        \ 'f:functions:1',
        \ 'g:enumerations:1',
        \ 't:type aliases:1:0',
        \ 'v:constants:1:0',
        \ 'M:macros:1',
        \ 'm:fields:1:0',
        \ 'e:enum variants:1:0',
        \ 'P:methods:1',
    \ ],
    \ 'sro': '::',
    \ 'kind2scope' : {
        \ 'n': 'module',
        \ 's': 'struct',
        \ 'i': 'interface',
        \ 'c': 'implementation',
        \ 'f': 'function',
        \ 'g': 'enum',
        \ 't': 'typedef',
        \ 'v': 'variable',
        \ 'M': 'macro',
        \ 'm': 'field',
        \ 'e': 'enumerator',
        \ 'P': 'method',
    \ },
  \ }

