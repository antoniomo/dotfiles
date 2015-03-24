#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set PATH with my user bin commands
PATH=$PATH:~/bin

# Envoy keychain
envoy
source <(envoy -p)

# Disable XON/XOFF (To enable CTRL-s for forward search)
stty -ixon

# History control, ignore duplicates and whitespace
export HISTCONTROL=ignoreboth
# When a shell exits, append to the history file, don't overwrite it
shopt -s histappend

# Autocd on path
shopt -s autocd

# Fix minor cd typos
shopt -s cdspell

# Fix minor directory name typos
shopt -s dirspell

# Line wrap on window resize
shopt -s checkwinsize

# Git stuff
source /usr/share/git/completion/git-prompt.sh
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWUPSTREAM="auto"
alias g=git
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g

# General aliases
alias ls='ls -F --color=auto'
alias ll='ls -lhA'
alias tree='tree -C'
alias ..='cd ..'
alias fhere='find . -iname '
alias ps='ps auxf'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias free='free -mt'
alias df='df -Th --total'
alias du='ncdu'
alias mkdir='mkdir -pv'
alias histg='history | grep'

export VISUAL=vim
export EDITOR="$VISUAL"
export PROMPT_DIRTRIM=2
PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'

# Fasd initialization, with cache (faster)
# Must be run after above PROMPT_COMMAND definition
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
# Fasd extra alias
alias v='f -e vim'  # quick opening files with vim
alias vv='f -i -e vim'  # opening files with vim and fasd interactive
alias o='a -e xdg-open'  # quick opening files/directories with xdg-open
alias oo='a -i -e xdg-open'  # opening files/directories with fasd interactive

