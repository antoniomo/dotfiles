set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" Sane defaults (Remember to make .vim/backup, .vim/undo and .vim/swap folders!)
Plugin 'tpope/vim-sensible'
" Indentation autodetection
Plugin 'tpope/vim-sleuth'
" Comment/uncomment plugin
Plugin 'tpope/vim-commentary'
" Useful extra mappings
Plugin 'tpope/vim-unimpaired'
" Git plugin
Plugin 'tpope/vim-fugitive'
" Netrw file manager plugin extension
Plugin 'tpope/vim-vinegar'
" Surrounds plugin
Plugin 'tpope/vim-surround'
" Git changes as signs
Plugin 'airblade/vim-gitgutter'
" i3 config syntax highlighting
Plugin 'PotatoesMaster/i3-vim-syntax'
" tmux config syntax highlighting
Plugin 'tmux-plugins/vim-tmux'
" Solarized colorscheme
Plugin 'altercation/vim-colors-solarized'
" ctrl + hjkl to move windows in tmux and vim effortlessly
Plugin 'christoomey/vim-tmux-navigator'
" YouCompleteMe autocompletion (Remember to run install.sh after upgrade!)
Plugin 'Valloric/YouCompleteMe'
" syntastic multi-language syntax checker and linter
Plugin 'scrooloose/syntastic'
" ctrlp fuzzy finder
Plugin 'kien/ctrlp.vim'
" Rainbow parenthesis and other symbols
Plugin 'kien/rainbow_parentheses.vim'
" Markdown and pandoc stuff
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
" Riv rst notetaking and instant html preview
Plugin 'Rykka/riv.vim'
Plugin 'Rykka/InstantRst'  " Has a python component, instant-rst (pip/repositories)
" Snippets
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
" Hex mode with binary files (open with vim -b file or use :Hexmode)
Plugin 'fidian/hexmode'

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

" Smartcase searching
set ignorecase
set smartcase

" Swap, undo and backup directories
set directory=~/.vim/swap
set undodir=~/.vim/undo
set backupdir=~/.vim/backup

" Solarized colorscheme
colorscheme solarized
"Default to the dark bg
set background=dark
" Toggle dark/light bg
call togglebg#map("<f3>")

" Highlight current cursor line
set cursorline
" Text width options
set textwidth=80
set colorcolumn=+1

" Minimum context lines above/below when scrolling
set scrolloff=5

" See trailing whitespaces, tabs...
runtime! plugin/sensible.vim
set list
let &listchars = "tab:\u21e5 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"

" Trailing whitespace stripper
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,php,ruby,python,rst,md,gitcommit,txt,tex autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" Spellchecking as default on some filetypes
autocmd FileType txt,tex,markdown,rst,gitcommit,python setlocal spell

" Files with 4 spaces as tabs
autocmd FileType python setlocal ts=4 sts=4 sw=4 et

" Don't expand tabs on makefiles
autocmd FileType make setlocal noexpandtab

" Netrw options
let g:netrw_liststyle=3  " 3=Tree style

" Autoreload .vimrc on write
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Syntastic options
" Check on open as well as save (default)
let g:syntastic_check_on_open=1

" ctrlp options
" Search in files, buffers, and MRU at the same time
let g:ctrlp_cmd='CtrlPMixed'

" InstantRst options
let g:instant_rst_localhost_only=1

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Rainbow parentheses always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound  " ()
au Syntax * RainbowParenthesesLoadSquare  " []
au Syntax * RainbowParenthesesLoadBraces  " {}
au Syntax * RainbowParenthesesLoadChevrons  " <>

" Allow saving of files as sudo when I forgot to start vim using sudo.
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" Enter the explorer if no file was passed
autocmd VimEnter * if !argc() | Explore | endif
