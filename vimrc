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

set wrapscan
set ignorecase
set smartcase

set nobackup
set writebackup

set scrolloff=2
set undolevels=1000
set nocompatible
set cindent
filetype on
filetype indent on
set autowrite
set wildmenu
set wildmode=list:longest,full

if v:version < 802
    packadd! dracula
endif
syntax enable
colorscheme dracula

:set list
:set listchars=trail:·
