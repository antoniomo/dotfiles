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
" Asynchronous for other plugins
Plug 'tpope/vim-dispatch'
" Word variants plugin (camelCase -> snake_case for example)
Plug 'tpope/vim-abolish'
" Automatic swap file handling
Plug 'gioele/vim-autoswap'
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
" NerdTree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" PlantUML support
Plug 'aklt/plantuml-syntax'
" Plug 'scrooloose/vim-slumlord'
" Dot (graphviz) support
Plug 'wannesm/wmgraphviz.vim'
" Ack/Ag plugin
Plug 'mileszs/ack.vim'
" Surrounds plugin
Plug 'tpope/vim-surround'
" Search visual star (* search for text selection, not just word)
Plug 'bronson/vim-visual-star-search'
" Sneak motions
Plug 'justinmk/vim-sneak'
" Git changes as signs
Plug 'airblade/vim-gitgutter'
" Autoclosing of parenthesis, brackets...
Plug 'Raimondi/delimitMate'
" Gundo, gundo is awesome (vim-mundo is another 'maintained' fork but currently broken)
" Plug 'dsummersl/gundo.vim'
" Undotree instead of gundo
Plug 'mbbill/undotree'
" i3 config syntax highlighting
Plug 'PotatoesMaster/i3-vim-syntax', {'for': 'i3'}
" tmux config syntax highlighting
" Plug 'tmux-plugins/vim-tmux'
" Molokai colorscheme
" Plug 'tomasr/molokai'
" Plug 'fatih/molokai' " Version with different line numbers
" Gruvbox colorscheme
Plug 'morhetz/gruvbox'
" Solarized true colors colorscheme!
" Plug 'lifepillar/vim-solarized8'
" ctrl + hjkl to move windows in tmux and vim effortlessly
" Plug 'christoomey/vim-tmux-navigator'
" YouCompleteMe autocompletion (Remember to run install.py after upgrade!)
Plug 'Valloric/YouCompleteMe', {'do': 'python install.py --gocode-completer'}
" Fuzzy-finder with fzf
Plug 'junegunn/fzf', {'do': 'yes \| ./install --all'}
" Plug 'junegunn/fzf.vim'
" Nesting indent levels visualizer
Plug 'nathanaelkane/vim-indent-guides'
" Ale multi language linter
Plug 'w0rp/ale'
" ctrlp fuzzy finder
Plug 'ctrlpvim/ctrlp.vim'
" Rainbow parenthesis and other symbols
Plug 'eapache/rainbow_parentheses.vim'
" Vim show marks and more
Plug 'kshenoy/vim-signature'
" Python-specific stuff
Plug 'hynek/vim-python-pep8-indent', {'for': 'python'}
" Markdown and pandoc stuff
Plug 'vim-pandoc/vim-pandoc', {'for': 'markdown'}
Plug 'vim-pandoc/vim-pandoc-syntax', {'for': 'markdown'}
Plug 'shime/vim-livedown', {'for': 'markdown'}  " Has a nodejs component, (npm/repositories)
" Riv rst notetaking and instant html preview
" Plug 'Rykka/riv.vim', {'for': 'rst'}
" Plug 'Rykka/InstantRst', {'for': 'rst'}  " Has a python component, instant-rst
" Vim extline for titles, headers, comments...
Plug 'drmikehenry/vim-extline'
" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" Hex mode with binary files (open with vim -b file or use :Hexmode)
" Plug 'fidian/hexmode'
" Jinja2 support
" Plug 'Glench/Vim-Jinja2-Syntax', {'for': 'jinja'}
" Go stuff
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'nsf/gocode', {'rtp': 'vim', 'for': 'go', 'do': '~/.vim/plugged/gocode/vim/symlink.sh'}
Plug 'AndrewRadev/splitjoin.vim'
" TOML
Plug 'cespare/vim-toml', {'for': 'toml'}
" Nim stuff
" Plug 'zah/nim.vim', {'for': 'nim'}
" Java Stuff
" Gradle support
" Plug 'tfnico/vim-gradle', {'for': 'java'}

" Add plugins to &runtimepath
call plug#end()

" To ignore plugin indent changes, instead use:
"filetype plugin on
filetype plugin indent on    " required

" Autoreload .vimrc on write
augroup reload_vimrc " {
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END " }

" Some nice defaults based on nvim
if !has("nvim")
  set ttyfast
  set ttymouse=xterm2
  set ttyscroll=3
  set backspace=indent,eol,start
  set autoread
  set autoindent
  set termguicolors " Finally in Vim!!
endif

" Other useful miscellanea
set lazyredraw
set autowrite " For the :make and :GoBuild and similar commands
set encoding=utf-8
set splitbelow
set splitright
set updatetime=250  " in ms

" Timeout keypress stuff, we want a responsive ESC key
set timeout
set timeoutlen=500
set ttimeoutlen=0

"NeoVim handles ESC keys as alt+key, set this to solve the problem
if has("nvim")
  set ttimeout
endif

" Mouse support
set mouse=a

" Space as leader
let mapleader = "\<Space>"

" Copy to system's selection clipboard (the one midmouse pastes)
set clipboard^=unnamed
set clipboard^=unnamedplus

" Search options
set ignorecase
set smartcase
set incsearch
set hlsearch
" Press return to clear search highlighting and any message already displayed.
nnoremap <silent> <CR> :noh<Bar>:echo<CR>

" Allow hidden unsaved buffers
set hidden

" Window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab navigation
nmap <silent> <leader>t :tabnew<CR>
nmap <silent> <leader>tc :tabclose<CR>
nmap <silent> [g :tabprevious<CR>
nmap <silent> ]g :tabnext<CR>
nmap <silent> [G :tabrewind<CR>
nmap <silent> ]G :tablast<CR>

" Quickfix window (unimpaired gives the [q ]q [Q ]Q ones
nmap <silent> <leader>q :cclose<CR>

" Swap, undo and backup options
set directory=~/.vim/swap//
:silent call system('mkdir -p ' . &directory)
set undodir=~/.vim/undo//
set undofile  " Persistent undo
:silent call system('mkdir -p ' . &undodir)
set backupdir=~/.vim/backup//
set backup
silent call system('mkdir -p ' . &backupdir)

" Toggle dark/light bg
map <F3> :let &background = ( &background == "dark"? "light" : "dark" )<CR>
" Molokai colorscheme
" let g:rehash256 = 1
" colorscheme molokai
set background=dark
let g:gruvbox_contrast_dark = "hard"
let g:gruvbox_contrast_light = "hard"
colorscheme gruvbox

" Highlight current cursor line
set cursorline
" Text width options
set textwidth=80
set colorcolumn=+1

" Minimum context lines above/below when scrolling
set scrolloff=5

" Set titlestring to full path of the edited file
set titlestring=%F

" Statusline options
" See `:help statusline` for more built-in flags
" See also:
" http://got-ravings.blogspot.fi/2008/08/vim-pr0n-making-statuslines-that-own.html
" http://got-ravings.blogspot.fi/search/label/statuslines
function! Showbranch()
  let branchname=fugitive#head()
  if branchname == ""
    return ""
  else
    return '⎇('.branchname.')' " Git branch
  endif
endfunction


set statusline=          " Clear the statusline when vimrc is loaded
set statusline+=[%n]\    " buffer number
set statusline+=%<%.60F\  " file name
set statusline+=%{Showbranch()} " Git branch
set statusline+=%h       " help file flag
set statusline+=%m       " modified flag
" set statusline+=%r       " read only flag, unneeded with the modified flag
set statusline+=%w       " preview window flag
set statusline+=%#warningmsg# " Colortheme's warningmsg color
set statusline+=%{LinterStatus()} " Ale linter status
set statusline+=%*       " Revert color back after warningmsg color
set statusline+=%=       " left/right separator, things after this go to the right
" set statusline+=[%{&ff}\| " file format (endline type, etc)
" set statusline+=%{strlen(&fenc)?&fenc:'none'}\|  " file encoding
" set statusline+=%Y]\     " filetype
set statusline+=%c:     " cursor column
set statusline+=%l/%L    " cursor line/total lines
" set statusline+=\ %P     " percent through file

" Vim starts in normal mode, put green statusline
runtime! plugin/sensible.vim
hi StatusLine term=reverse cterm=reverse ctermfg=green ctermbg=black guifg=green guibg=black
" Change the status line color based on mode
if version >= 700
  " use red insert mode
  au InsertEnter * hi StatusLine term=reverse cterm=reverse ctermfg=red ctermbg=black guifg=red guibg=black
  " use green otherwise
  au InsertLeave * hi StatusLine term=reverse cterm=reverse ctermfg=green ctermbg=black guifg=green guibg=black
endif

" Change cursor color according to mode
if &term =~ "xterm\\|rxvt"
  " use a red cursor in insert mode
  let &t_SI = "\<Esc>]12;Red\x7"
  " use a green cursor otherwise
  let &t_EI = "\<Esc>]12;LightGreen\x7"
  " do it here so it's in normal mode at the start too
  silent !echo -ne "\033]12;LightGreen\007"
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
autocmd FileType c,cpp,java,php,ruby,python,rst,md,gitcommit,txt,tex,htm,html autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

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

" Ignore some filetypes
set wildignore+=*.pyc,*.jpg,*.png,*.gif,*.pdf,*.zip,*.gz,*.bz2,vendor

" Netrw options
let g:netrw_preview=1    " Previews are vertical by default
let g:netrw_liststyle=3  " 3=Tree style
let g:netrw_keepdir=0    " Browsed dir is current pwd
let g:netrw_list_hide= netrw_gitignore#Hide()  " Ignore what's on gitignore

" NerdTree option
map <F2> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden=1
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

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

" Ack/Ag options, prefer ripgrep (rg) if available
if executable('rg')
  let g:ackprg = 'rg --vimgrep'
endif

" Ale options
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {'go': ['go build', 'gofmt', 'go vet', 'golint', 'gosimple', 'staticcheck']}

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%sW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

" Gundo options
" nnoremap <F5> :GundoToggle<CR>
" let g:gundo_preview_bottom = 1

" Undotree options
nnoremap <F5> :UndotreeToggle<cr>
nnoremap U :UndotreeToggle<CR>
let g:undotree_WindowLayout = 2

" ctrlp options
" Search in files, buffers, and MRU at the same time
let g:ctrlp_cmd='CtrlPMixed'
" http://dougblack.io/words/a-good-vimrc.html#ctrlp-section
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" fzf options
" Ideas from https://github.com/junegunn/dotfiles/blob/master/vimrc
" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ?  "\<c-w>\<c-w>" : '').":GitFiles\<cr>"
" nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
" nnoremap <silent> <Leader><Enter> :Buffers<CR>
" imap <c-x><c-l> <plug>(fzf-complete-line)
" imap <c-x><c-f> <plug>(fzf-complete-file-ag)
" imap <c-x><c-p> <plug>(fzf-complete-path)

" Indent-guides
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=10
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=11
let g:indent_guides_guide_size=1

" Interop between git gutter and signature
let g:SignatureMarkTextHLDynamic = 1
let g:SignatureMarkerTextHLDynamic = 1

" InstantRst options
" let g:instant_rst_localhost_only=1

" YouCompleteMe
let g:ycm_allow_changing_updatetime = 0  " We are setting it manually
let g:ycm_complete_in_comments = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_key_list_select_completion = ['<TAB>', '<Down>']
let g:ycm_key_list_previous_completion=['<S-TAB>', '<Up>']
let g:ycm_python_binary_path = '/usr/bin/python3'

" Sneak
let g:sneak#streak = 1
" hi link SneakPluginTarget ErrorMsg
" hi link SneakPluginScope  Comment
" hi link SneakStreakTarget ErrorMsg
" hi link SneakStreakMask  Comment
" hi link SneakStreakStatusLine  Comment

" Ultisnips
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" Pandoc/markdown stuff
let g:pandoc#modules#disabled = ["folding"]
" livedown
let g:livedown_autorun = 1  " Open livedown automatically with markdown files
let g:livedown_open = 1  " Open browser window upon previewing
let g:livedown_browser = "chromium"
" Riv (rst)
" let g:riv_disable_folding = 1

" Rainbow parentheses always on
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound  " ()
au Syntax * RainbowParenthesesLoadSquare  " []
au Syntax * RainbowParenthesesLoadBraces  " {}
" au Syntax * RainbowParenthesesLoadChevrons  " <>

" Allow saving of files as sudo when I forget to start vim like that.
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work
cmap w!! w !sudo tee > /dev/null %

" Enter the explorer if no file was passed
autocmd VimEnter * if !argc() | Explore | endif

" Delimitmate
let delimitMate_expand_cr = 1

" Vim-go options, golang
let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_fmt_options = {
  \ 'gofmt': '-s',
  \ }
let g:go_fmt_autosave = 1
let g:go_metalinter_autosave = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1
let g:go_snippet_case_type = "camelcase"
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'gosimple']
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'gosimple']

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>r <Plug>(go-run)
autocmd FileType go nmap <leader>t <Plug>(go-test)
autocmd FileType go nmap <leader>c <Plug>(go-coverage-toggle)

" Vim-nim
" fun! JumpToDef()
"   if exists("*GotoDefinition_" . &filetype)
"     call GotoDefinition_{&filetype}()
"   else
"     exe "norm! \<C-]>"
"   endif
" endf

" Jump to tag
" nn <M-g> :call JumpToDef()<cr>
" ino <M-g> <esc>:call JumpToDef()<cr>i
" End vim-nim
