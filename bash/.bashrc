#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set PATH with my user bin commands
PATH=$PATH:~/bin:~/go/bin
export GOPATH=~/go
export CDPATH=.:$HOME:$GOROOT/src:$GOPATH/src:$GOPATH/src/golang.org:$GOPATH/src/github.com:

# Envoy keychain
# envoy
# source <(envoy -p)

# Vi keybindings (inputrc is sourced after this, so some bash stuff prefers this
# setting)
set -o vi

# Disable XON/XOFF (To enable CTRL-s for forward search)
stty -ixon

# Big history
export HISTSIZE=10000
# History control, ignore duplicates and whitespace, and erase old dups
export HISTCONTROL=ignoreboth:erasedups
# When a shell exits, append to the history file, don't overwrite it
shopt -s histappend

# Autocd on path
shopt -s autocd
# Fix minor cd typos
shopt -s cdspell
# Fix minor typos when tab-completing directores
shopt -s dirspell
# Line wrap on window resize
shopt -s checkwinsize
# Awesome extended globs
shopt -s extglob
# Recursive globbing with two **
shopt -s globstar
# Store multi-line commands in shell history as one-liners for easy editing
shopt -s cmdhist
# Don't try to complete on empty lines
shopt -s no_empty_cmd_completion
# Globs won't consider case
shopt -s nocaseglob
# Globs will consider hidden files, too
shopt -s dotglob

# Set LS_COLORS
eval $(dircolors -b)

# Set GCC colors (gcc >= 4.9). Those colors should be the defaults but setting
# the variable activates the -fdiagnostics-color=auto flag
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Virtualenvwrapper and other python stuff
# export WORKON_HOME=~/.Envs
# We set the venv prompt PROMPT_COMMAND directly
# export VIRTUAL_ENV_DISABLE_PROMPT=1
# source /usr/bin/virtualenvwrapper_lazy.sh

pyclean () {
  find . -type f -name "*.py[co]" -delete
  find . -type d -name "__pycache__" -delete
}

# Git stuff
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
alias g=hub
alias git=hub
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g

# General aliases
alias sudo='sudo '  # Enables aliases with sudo
alias ssh='TERM=xterm-256color ssh '
alias please='sudo $(fc -ln -1)'
alias grep='grep --color=auto'
alias clipcopy='xclip -selection c'
alias clippaste='xclip -selection clipboard -o'
alias pbcopy='xclip -selection c' # OSX script compatibility
alias pbpaste='xclip -selection clipboard -o' # OSX script compatibility
alias diff=colordiff
alias lsofst="lsof | awk '{ print \$2 \" \" \$1; }' | sort -rn | uniq -c | sort -rn | head -20"
alias rm='rm -I'
alias ls='ls -F --group-directories-first --color=auto'
alias ll='ls -lhA'
alias tree='tree -C'
alias time='command time'  # Use time command instead of bash builtin
alias fhere='find . -iname '
# alias ps='ps auxf'  # Conflicts with fzf kill
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias zag='ag -z'
alias free='free -mt'
alias df='df -Th --total'
alias du='ncdu'
alias mkdir='mkdir -pv'
alias histg='history | grep'
alias myip='curl http://ipecho.net/plain; echo'
alias jsonpp='python -mjson.tool'
alias unp='unp -U'
alias o='xdg-open'
alias v='vim'
alias :e='vim'
alias nc='ncat'
alias netcat='ncat'
alias ungron='gron -u'

# Function so that it can be used by make
function go(){
  if [ -x "$(command -v richgo)" ]; then
    richgo "$@"
  else
    command go "$@"
  fi
}
export -f go
alias make='make --eval=SHELL=/bin/bash'

# List all dependencies
function godeps(){
  go list -f '{{ join .Deps "\n" }}'
}

# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
# Taken from: http://pastebin.com/pZ0hVDq8
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//     '\'')"'

# Executes stuff in parallel for all subdirectories
function mapd(){
  ls -d */ | parallel "cd {} && $@"
}

function say(){
  flite -voice slt -t "'$*'"
}

# Systemctl aliases/functions
alias sls='sudo systemctl list-units'
alias sg='sudo systemctl list-units|grep -iE'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
alias sst='sudo systemctl status -n0'
function sstart(){
  sudo systemctl start "$@"
  sudo systemctl status -n0 "$@"
}
function sstop(){
  sudo systemctl stop "$@"
  sudo systemctl status -n0 "$@"
}
function srestart(){
  sudo systemctl restart "$@"
  sudo systemctl status -n0 "$@"
}
function sreload(){
  sudo systemctl reload "$@"
  sudo systemctl status -n0 "$@"
}
function skill(){
  sudo systemctl kill "$@"
  sudo systemctl status -n0 "$@"
}

# Compress/decompress in parallel
XZ_DEFAULTS="-T 0"

function gzip(){
  pigz $@
}
export -f gzip

function gunzip(){
  unpigz $@
}
export -f gunzip

function bzip2(){
  pbzip2 $@
}
export -f bzip2

function bunzip2(){
  pbunzip2 $@
}
export -f bunzip2

function bzcat(){
  pbzcat $@
}
export -f bzcat

# Kubernetes/gcloud extra aliases
if [ -e ~/.mykuberc ];then
  source ~/.mykuberc
fi

# Settings not found here or in dotfiles (having sensitive info)
if [ -e ~/.localrc ];then
  source ~/.localrc
fi

# Next two from
# https://www.reddit.com/r/linux/comments/23zibr/hey_reddit_linux_users_what_are_your_best_shell/
# Lazy change into directory by partial name
# From /, c ho an -> cd /home/antonio
c () {
    ls='ls -A -sh --color=auto'
    if [[ $1 ]]; then
        if [[ $1 == '-q' ]]; then
            ls='true'
            shift
        fi
        for dir in "$@"; do
            if [[ -d $dir ]]; then
                command cd "$dir"
            else
                command cd *"${dir}"*
            fi
        done
    else
        command cd ~
    fi
}

# Go up the path by level or partial and safe match, awesome
# .. 3 to go up 3 levels
# .. bla to go up until `bla` partially matches directory name
.. () {
    if [[ $1 =~ ^[0-9]*$ ]]; then
        for ((n=0; n<${1:-1}; n++)); do
            cd ..
        done
    else
        if [[ ${PWD,,} =~ "${1,,}" ]]; then
            p="$PWD/"
            while [[ $p ]]; do
                n=${p##*/}
                if [[ $n && ${n,,} =~ "${1,,}" ]]; then
                    echo "$p"
                    cd "$p"
                    return 0
                else
                    p=${p%/*}
                fi
            done
            return 1
        else
            echo 'No matching path found.'
            return 1
        fi
    fi
}

#View specified line range of a file:
# viewlines 13 37 file.txt  # Displays lines 13-37 of file.txt
viewlines () { sed -n ''$1','$2'p' $3; }

# CLI calculator
# Quote any complex calculation with spaces or parenthesis
# $ calc "(3 + 2) * 2"
calc(){ awk "BEGIN{ print $* }"; }

# Usefult to get repeatable random filebased seeds
# Sample usage: shuf -n 100 infile --random-source=<(get_seeded_random 42) -o outfile
get_seeded_random()
{
  seed="$1"
  openssl enc -aes-256-ctr -pass pass:"$seed" -nosalt \
    </dev/zero 2>/dev/null
}
alias shuf='shuf --random-source=<(get_seeded_random 42)'

# git+github.com:amacias/Oblique-Strategies.git
alias strat='fortune ~/opt/Oblique-Strategies'

# Pager and editor options and helper function

# http://stackoverflow.com/questions/1401002/trick-an-application-into-thinking-its-stdin-is-interactive-not-a-pipe
function faketty { 0<&- script -qfc "$(printf "'%s' " "$@")" /dev/null; }
export LESSOPEN='|/usr/bin/lesspipe.sh %s'
export LESSCOLORIZER='pygmentize'
export LESS='-R -X '
export PAGER=less
export VISUAL=vim
export EDITOR="$VISUAL"

export BROWSER=chromium

# Fasd initialization, with cache (faster)
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
# Sets _fasd_prompt_func in PROMPT_COMMAND, re-add it if redefined
source "$fasd_cache"
unset fasd_cache

# FZF stuff (sourced at the end for compatibility with it's install script)
export FZF_DEFAULT_COMMAND='rg --hidden -g "" --files ~/'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="rg --hidden -g "" --files --null ~/ | xargs -0 dirname | sort -u"
export FZF_COMPLETION_TRIGGER='~~'
export FZF_TMUX=0  # Disable tmux integration
# Ctrl-p as a ctrl-t synonim
bind -x '"\C-p": "fzf-file-widget"'
bind -m vi-command '"\C-p": "i\C-p"'
alias oo='xdg-open "$(fzf)"'
alias vv='vim "$(fzf)"'
# For bash completion functions
_fzf_compgen_path() {
  rg --hidden -g "" --files "$1"
}

# gshow - git commit browser
gshow() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --header "Press CTRL-S to toggle sort" \
      --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
                 xargs -I % sh -c 'git show --color=always % | head -$LINES'" \
      --bind "enter:execute:echo {} | grep -o '[a-f0-9]\{7\}' | head -1 |
              xargs -I % sh -c 'vim fugitive://\$(git rev-parse --show-toplevel)/.git//% < /dev/tty'"
}

# Prompt stuff
# http://mywiki.wooledge.org/BashFAQ/037
reset="\[`tput sgr0`\]"          # Text Reset
bold="\[`tput bold`\]"           # Bold
red="\[`tput setaf 1`\]"         # Red
green="\[`tput setaf 2`\]"       # Green
yellow="\[`tput setaf 3`\]"      # Yellow
blue="\[`tput setaf 4`\]"        # Blue
white="\[`tput setaf 7`\]"       # White
export PROMPT_DIRTRIM=2

set_last_err (){
  # This must be set first in PROMPT_COMMAND
  last_st=$?
}

last_err () {
  # Outputs last command error code
  if [[ $last_st != 0 ]]; then
    echo "${white}Error:$red $last_st"
  fi
}

venv () {
  # Outputs active virtualenv, if any
  echo ${VIRTUAL_ENV:+($green`basename $VIRTUAL_ENV`$reset)}
}

ssh_host () {
  # Hostname only on ssh connections
  if [[ -n $SSH_CLIENT ]]; then
    echo "$blue\u@\h:"
  fi
}

root_prompt () {
  # Red # or green $ for root/normal user prompt
  if [[ $EUID == 0 ]]; then
    echo "$bold$red#$reset"
  else
    echo "$green\$$reset"
  fi
}

# From
# http://stackoverflow.com/questions/1862510/how-can-the-last-commands-wall-time-be-put-in-the-bash-prompt/2732282

timer_start () {
  timer=${timer:-$SECONDS}
}

timer_stop () {
  elapsed_time=$(($SECONDS - $timer))
  unset timer
}

timer_show () {
  # Show time elapsed on last command, for slow commands
  if [[ $elapsed_time -ge 10 ]]; then
    printf "${white}Time: $red%02d$white:$red%02d$white:$red%02d" $(( $elapsed_time/3600 )) $(( $elapsed_time/60%60 )) $(( $elapsed_time % 60 ))
  fi
}

last_cmd_status () {
  # Print last command status
  ret1=`last_err`
  ret2=`timer_show`
  ret="$bold$blue["
  prnt=false
  if [[ -n $ret1 ]]; then
    ret+=$ret1
    prnt=true
  fi
  if [[ -n $ret2 ]]; then
    if $prnt; then
      ret+="$blue | "
    fi
    ret+=$ret2
    prnt=true
  fi
  if $prnt; then
    echo "$ret$blue]$reset\n"
  fi
}

# Workaround for qterminal TERM variable setting
[[ $(< /proc/$PPID/cmdline tr -d \\0) == *qterminal* ]] && export TERM="xterm-256color"

# Kubernetes-aware prompt
source /home/antonio/opt/kube-ps1/kube-ps1.sh
# Not show the default namespace
KUBE_PS1_NS_DEFAULT_ENABLE=false

trap 'timer_start' DEBUG
PROMPT_COMMAND='set_last_err;timer_stop;history -n;history -w;history -c; history -r;_kube_ps1_update_cache;__git_ps1 "`last_cmd_status``venv``ssh_host`$yellow\w$reset" "`kube_ps1``root_prompt` ";_fasd_prompt_func;timer_stop'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
