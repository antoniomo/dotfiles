set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Sane defaults
Plugin 'tpope/vim-sensible'
" Indentation autodetection
Plugin 'tpope/vim-sleuth'
" Comment/uncomment plugin
Plugin 'tpope/vim-commentary'
" Useful extra mappings
Plugin 'tpope/vim-unimpaired'
" i3 config syntax highlighting
Plugin 'PotatoesMaster/i3-vim-syntax'
" tmux config syntax highlighting
Plugin 'tmux-plugins/vim-tmux'
" Solarized colorscheme
Plugin 'altercation/vim-colors-solarized'
" ctrl + hjkl to move windows in tmux and vim effortlessly
Plugin 'christoomey/vim-tmux-navigator'
" YouCompleteMe autocompletion
Plugin 'Valloric/YouCompleteMe'
" syntastic multi-language syntax checker and linter
Plugin 'scrooloose/syntastic'
" ctrlp fuzzy finder
Plugin 'kien/ctrlp.vim'
" Markdown and pandoc stuff
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Mouse support
set mouse=a

" Solarized colroscheme
colorscheme solarized
set cursorline
set colorcolumn=80
" Toggle dark/light bg
call togglebg#map("<f3>")

" Trailing whitespace stripper
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" See trailing whitespaces, tabs...
runtime! plugin/sensible.vim
set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
