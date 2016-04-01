#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set PATH with my user bin commands
PATH=$PATH:~/bin:~/go/bin
export GOPATH=~/go

# Envoy keychain
envoy
source <(envoy -p)

# Vi keybindings (inputrc is sourced after this, so some bash stuff prefers this
# setting)
set -o vi

# Disable XON/XOFF (To enable CTRL-s for forward search)
stty -ixon

# Big history
export HISTSIZE=10000
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
# Recursive globbing with two **
shopt -s globstar

# Set LS_COLORS
eval $(dircolors -b)

# Set GCC colors (gcc >= 4.9). Those colors should be the defaults but setting
# the variable activates the -fdiagnostics-color=auto flag
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Virtualenvwrapper and other python stuff
export WORKON_HOME=~/.Envs
# We set the venv prompt PROMPT_COMMAND directly
export VIRTUAL_ENV_DISABLE_PROMPT=1
source /usr/bin/virtualenvwrapper_lazy.sh

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
alias g=git
source /usr/share/bash-completion/completions/git
complete -o default -o nospace -F _git g

# General aliases
alias sudo='sudo '  # Enables aliases with sudo
alias grep='grep --color=auto'
alias diff=colordiff
alias ls='ls -F --color=auto'
alias ll='ls -lhA'
alias tree='tree -C'
alias time='command time'  # Use time command instead of bash builtin
alias fhere='find . -iname '
# alias ps='ps auxf'  # Conflicts with fzf kill
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias free='free -mt'
alias df='df -Th --total'
alias du='ncdu'
alias mkdir='mkdir -pv'
alias histg='history | grep'
alias myip='curl http://ipecho.net/plain; echo'
alias jsonpp='python -mjson.tool'
alias ipython='ptipython'
alias ipython2='ptipython2'
alias unp='unp -U'
alias o='xdg-open'
alias v='vim'
# Prepare nikola tab completion when first invoked
alias nikola='source ~/opt/antoniomo.github.io/_nikola_bash;unalias nikola;nikola'
# Add an "alert" alias for long running commands.  Use like so:
# sleep 10; alert
# Taken from: http://pastebin.com/pZ0hVDq8
alias alert='notify-send --urgency=critical -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//     '\'')"'

# Systemctl aliases
alias sls='sudo systemctl list-units'
alias sg='sudo systemctl list-units|grep -iE'
alias sst='sudo systemctl status -n0'
alias sstart='sudo systemctl start'
alias sstop='sudo systemctl stop'
alias srestart='sudo systemctl restart'
alias sreload='sudo systemctl reload'
alias senable='sudo systemctl enable'
alias sdisable='sudo systemctl disable'
alias skill='sudo systemctl kill'

# Settings not found here or in dotfiles (having sensitive info)
if [ -e ~/.localrc ];then
  source ~/.localrc
fi

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
export LESS='-R '
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

# Updates database of locate for use in fzf
alias updatefzfdb='sudo updatedb; locate ~ > ~/.homefilesdb'

# FZF stuff (sourced at the end for compatibility with it's install script)
# export FZF_DEFAULT_COMMAND='ag --hidden -g ""'
export FZF_DEFAULT_COMMAND='cat ~/.homefilesdb'
export FZF_CTRL_T_COMMAND='cat ~/.homefilesdb'
export FZF_ALT_C_COMMAND='\tree -dnif --noreport'
export FZF_COMPLETION_TRIGGER='***'
alias oo='xdg-open "$(fzf)"'
alias vv='vim "$(fzf)"'
# For bash completion functions
_fzf_compgen_path() {
  ag --hidden -g "" "$1"
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

trap 'timer_start' DEBUG
PROMPT_COMMAND='set_last_err;timer_stop;history -a;history -n;__git_ps1 "`last_cmd_status``venv``ssh_host`$yellow\w$reset" "`root_prompt` ";_fasd_prompt_func;echo -ne "\033]0;$PWD\007";timer_stop'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
