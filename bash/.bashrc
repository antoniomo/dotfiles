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

# Virtualenvwrapper stuff
export WORKON_HOME=~/.virtualenvs
# We set the venv prompt PROMPT_COMMAND directly
export VIRTUAL_ENV_DISABLE_PROMPT=1
source /usr/bin/virtualenvwrapper_lazy.sh

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
alias sudo='sudo '  # Enables aliases with sudo
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

# Systemctl aliases
alias sls='sudo systemctl list-units'
alias sg='sudo systemctl list-units|grep -iE'
alias sst='sudo systemctl status'
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sreload='sudo systemctl reload'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'

export VISUAL=vim
export EDITOR="$VISUAL"

# Fasd initialization, with cache (faster)
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
# Sets _fasd_prompt_func in PROMPT_COMMAND, re-add it if redefined
source "$fasd_cache"
unset fasd_cache
# Fasd extra alias
alias v='f -e vim'  # quick opening files with vim
alias vv='f -i -e vim'  # opening files with vim and fasd interactive
alias o='a -e xdg-open'  # quick opening files/directories with xdg-open
alias oo='a -i -e xdg-open'  # opening files/directories with fasd interactive

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

set_last_st (){
  # This must be set first in PROMPT_COMMAND
  last_st=$?
}

last_st () {
  # Outputs last command status
  if [[ $last_st != 0 ]]; then
    echo "$bold$blue[$white$last_st $red:_$blue]$reset\n"
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

PROMPT_COMMAND='set_last_st;__git_ps1 "`last_st``venv``ssh_host`$yellow\w$reset" "`root_prompt` ";_fasd_prompt_func'
