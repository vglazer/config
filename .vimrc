set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent nu
set smartindent
set incsearch

set nowrap
set number
set ruler
set showcmd
set showmatch
set showmode
set cursorline
set bs=2

"set foldmethod=syntax
"set foldcolumn=2
"set foldlevel=2

set wrapscan
set ignorecase
set smartcase

set nobackup
set writebackup

filetype plugin on
set ofu=syntaxcomplete#Complete
autocmd FileType python set
set tags+=$HOME/.vim/tags/python.ctags
set tags+=$HOME/.vim/tags/cpp

" build tags of your own project with Ctrl-F11
"map <F11> :!ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

set scrolloff=2
set undolevels=1000
set nocompatible
set cindent
filetype on
filetype indent on
set autowrite
syntax on
set wildmenu
set wildmode=list:longest,full
