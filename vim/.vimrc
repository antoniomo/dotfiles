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
" Dot (.) repeat for plugin commands
Plugin 'tpope/vim-repeat'
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
" Autoclosing of parenthesis, brackets...
Plugin 'Raimondi/delimitMate'
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
" Vim show marks and more
Plugin 'kshenoy/vim-signature'
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
" Jinja2 support
Plugin 'mitsuhiko/vim-jinja'

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

" Search options
set ignorecase
set smartcase
set hlsearch
" Press return to clear search highlighting and any message already displayed.
nnoremap <silent> <CR> :noh<Bar>:echo<CR>

" Swap, undo and backup directories
set directory=~/.vim/swap
set undodir=~/.vim/undo
set backupdir=~/.vim/backup

" Toggle dark/light bg
call togglebg#map("<f3>")
" Solarized colorscheme
colorscheme solarized
"Default to the dark bg
set background=dark

" Highlight current cursor line
set cursorline
" Text width options
set textwidth=80
set colorcolumn=+1

" Minimum context lines above/below when scrolling
set scrolloff=5

" Statusline options
" See `:help statusline` for more built-in flags
" See also:
" http://got-ravings.blogspot.fi/2008/08/vim-pr0n-making-statuslines-that-own.html
" http://got-ravings.blogspot.fi/search/label/statuslines
set statusline=          " Clear the statusline when vimrc is loaded
set statusline+=[%n]\    " buffer number
set statusline+=%<%.40f\   " file name
set statusline+=%h       " help file flag
set statusline+=%m       " modified flag
set statusline+=%r       " read only flag
set statusline+=%w       " preview window flag
set statusline+=%{fugitive#statusline()} " Git branch
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%=       " left/right separator, things after this go to the right
set statusline+=[%{&ff}\| " file format (endline type, etc)
set statusline+=%{strlen(&fenc)?&fenc:'none'}\|  " file encoding
set statusline+=%Y]\     " filetype
set statusline+=%c:     " cursor column
set statusline+=%l/%L    " cursor line/total lines
set statusline+=\ %P     " percent through file

" Vim starts in normal mode, put green statusline
runtime! plugin/sensible.vim
hi StatusLine term=reverse cterm=reverse ctermfg=2 ctermbg=0
" Change the status line color based on mode
if version >= 700
  " use magenta insert mode
  au InsertEnter * hi StatusLine term=reverse cterm=reverse ctermfg=5 ctermbg=0
  " use green otherwise
  au InsertLeave * hi StatusLine term=reverse cterm=reverse ctermfg=2 ctermbg=0
endif

" Change cursor color according to mode
if &term =~ "xterm\\|rxvt"
  " use a magenta cursor in insert mode
  let &t_SI = "\<Esc>]12;5\x7"
  " use a green cursor otherwise
  let &t_EI = "\<Esc>]12;2\x7"
  " do it here so it's in normal mode at the start too
  silent !echo -ne "\033]12;2\007"
  " reset cursor when vim exits
  autocmd VimLeave * silent !echo -ne "\033]12;\#93a1a1\007"
endif

" See trailing whitespaces, tabs...
runtime! plugin/sensible.vim
set list
set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let &listchars = "tab:\u25b8 ,trail:\u2423,extends:\u21c9,precedes:\u21c7,nbsp:\u00b7"
endif

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
let g:netrw_keepdir=0    " Browsed dir is current pwd

" Autoreload .vimrc on write
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Syntastic options
" Check on open as well as save (default)
let g:syntastic_check_on_open=1
let g:syntastic_aggregate_errors=1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_python_flake8_args='--max-line-length=99'
let g:syntastic_python_flake8_exec='flake8-python2'  " Use py2 as default

" ctrlp options
" Search in files, buffers, and MRU at the same time
let g:ctrlp_cmd='CtrlPMixed'

" Interop between git gutter and signature
" Taken from: https://gist.github.com/kshenoy/14f2c4ce7af28b54882b
" This function returns the highlight group used by git-gutter depending on how
" the line was edited (added/modified/deleted) It must be placed in the vimrc
" (or in any file that is sourced by vim)
function! SignatureGitGutter(lnum)
  let gg_line_state = filter(copy(gitgutter#diff#process_hunks(gitgutter#hunk#hunks())), 'v:val[0] == a:lnum')
  "echo gg_line_state

  if len(gg_line_state) == 0
    return 'Exception'
  endif

  if gg_line_state[0][1] =~ 'added'
    return 'GitGutterAdd'
  elseif gg_line_state[0][1] =~ 'modified'
    return 'GitGutterChange'
  elseif gg_line_state[0][1] =~ 'removed'
    return 'GitGutterDelete'
  endif
endfunction

" Next, assign it to g:SignatureMarkTextHL
let g:SignatureMarkTextHL = 'SignatureGitGutter(a:lnum)'
" Now everytime Signature wants to place a sign, it calls this function and
" thus, we can dynamically assign a Highlight group g:SignatureMarkTextHL The
" advantage of doing it this way is that this decouples Signature from
" git-gutter. Both can remain unaware of the other.

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

" Git gutter column color = number color column (LineNr)
highlight clear SignColumn
" vim-gitgutter will use Sign Column to set its color, reload it.
call gitgutter#highlight#define_highlights()
