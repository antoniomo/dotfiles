set nocompatible              " be iMproved, required
filetype off                  " required

"Vim-plug to manage my plugins
call plug#begin('~/.vim/plugged')

" Sane defaults
Plug 'tpope/vim-sensible'
" Indentation autodetection
Plug 'tpope/vim-sleuth'
" Dot (.) repeat for plugin commands
Plug 'tpope/vim-repeat'
" Comment/uncomment plugin
Plug 'tpope/vim-commentary'
" Useful extra mappings
Plug 'tpope/vim-unimpaired'
" Git plugin
Plug 'tpope/vim-fugitive'
" Netrw file manager plugin extension
Plug 'tpope/vim-vinegar'
" Tagbar
Plug 'majutsushi/tagbar'
" Ack/Ag plugin
Plug 'mileszs/ack.vim'
" Surrounds plugin
Plug 'tpope/vim-surround'
" Git changes as signs
Plug 'airblade/vim-gitgutter'
" Autoclosing of parenthesis, brackets...
Plug 'Raimondi/delimitMate'
" Gundo, gundo is awesome
Plug 'sjl/gundo.vim'
" i3 config syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax', {'for': 'i3'}
" tmux config syntax highlighting
Plug 'tmux-plugins/vim-tmux'
" Solarized colorscheme
" Plug 'altercation/vim-colors-solarized'
" Base16 colorscheme
Plug 'chriskempson/base16-vim'
" ctrl + hjkl to move windows in tmux and vim effortlessly
Plug 'christoomey/vim-tmux-navigator'
" YouCompleteMe autocompletion (Remember to run install.sh after upgrade!)
Plug 'Valloric/YouCompleteMe', {'do': 'python2 install.py --clang-completer --system-libclang --system-boost --gocode-completer'}
" Fuzzy-select stuff with pick
Plug 'thoughtbot/pick.vim'
" syntastic multi-language syntax checker and linter
Plug 'scrooloose/syntastic'
" ctrlp fuzzy finder
Plug 'kien/ctrlp.vim'
" Rainbow parenthesis and other symbols
Plug 'kien/rainbow_parentheses.vim'
" Vim show marks and more
Plug 'kshenoy/vim-signature'
" Python-specific stuff
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
" Markdown and pandoc stuff
Plug 'vim-pandoc/vim-pandoc', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': 'markdown'}
Plug 'shime/vim-livedown', {'for': 'markdown'}  " Has a nodejs component, (npm/repositories)
" Riv rst notetaking and instant html preview
Plug 'Rykka/riv.vim', {'for': 'rst'}
Plug 'Rykka/InstantRst', {'for': 'rst'}  " Has a python component, instant-rst
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Hex mode with binary files (open with vim -b file or use :Hexmode)
Plug 'fidian/hexmode'
" Jinja2 support
Plug 'mitsuhiko/vim-jinja', {'for': ['jinja', 'jinja2']}
" Go stuff
Plug 'fatih/vim-go', {'for': 'go'}
" Java Stuff
" Gradle support
Plug 'tfnico/vim-gradle', {'for': 'java'}

" Add plugins to &runtimepath
call plug#end()

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on

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
:silent call system('mkdir -p ' . &directory)
set undodir=~/.vim/undo
:silent call system('mkdir -p ' . &undodir)
set backupdir=~/.vim/backup
:silent call system('mkdir -p ' . &backupdir)

" Toggle dark/light bg
map <F3> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" Solarized colorscheme
" colorscheme solarized

" Base16 colorscheme
colorscheme base16-bright

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
set statusline+=%{fugitive#statusline()} " Git branch
set statusline+=%h       " help file flag
set statusline+=%m       " modified flag
set statusline+=%r       " read only flag
set statusline+=%w       " preview window flag
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
  " use red insert mode
  au InsertEnter * hi StatusLine term=reverse cterm=reverse ctermfg=1 ctermbg=0
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
set listchars=tab:>\ ,trail:-,nbsp:+,extends:>,precedes:<
set showbreak="+++ "
" Improve non-text visibility (includes showbreak)
highlight NonText ctermfg=1
" Don't wrap midword (looks like it works with list now)
set linebreak
" Preserve indentation when wrapping
set breakindent
if !has('win32') && (&termencoding ==# 'utf-8' || &encoding ==# 'utf-8')
  let &listchars="tab:▸\ ,trail:␣,nbsp:·,extends:⇉,precedes:⇇"
  let &showbreak="↪"
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
" Use gq to clean up code
" Indent to 0 because otherwise it pushes selected lines to the given
" indent-size, no matter the current indent level of the line.
" au FileType python setlocal formatprg=autopep8\ -aa\ --indent-size\ 0\ --max-line-length\ 99\ -

" Don't expand tabs on makefiles
autocmd FileType make setlocal noexpandtab

" Netrw options
let g:netrw_liststyle=3  " 3=Tree style
let g:netrw_keepdir=0    " Browsed dir is current pwd
let g:netrw_list_hide= netrw_gitignore#Hide()  " Ignore what's on gitignore

" Tagbar options
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

" Ack/Ag options, prefer ag if available
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

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
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--max-line-length=99'
let g:syntastic_python_flake8_exec='flake8-python2'  " Use py2 as default

" Gundo options
nnoremap <F5> :GundoToggle<CR>
let g:gundo_preview_bottom = 1

" ctrlp options
" Search in files, buffers, and MRU at the same time
let g:ctrlp_cmd='CtrlPMixed'

" Pick options
nnoremap <Leader>p :call PickFile()<CR>
nnoremap <Leader>s :call PickFileSplit()<CR>
nnoremap <Leader>v :call PickFileVerticalSplit()<CR>
nnoremap <Leader>t :call PickFileTab()<CR>
nnoremap <Leader>b :call PickBuffer()<CR>
nnoremap <Leader>] :call PickTag()<CR>

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

" YouCompleteMe
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>', '<Enter>']
let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>', '<S-Enter>']

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Pandoc/markdown stuff
let g:pandoc#modules#disabled = ["folding"]
" livedown
let g:livedown_autorun = 1  " Open livedown automatically with markdown files
let g:livedown_open = 1  " Open browser window upon previewing

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
