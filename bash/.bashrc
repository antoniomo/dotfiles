#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Envoy keychain
envoy
source <(envoy -p)

# Fasd initialization, with cache (faster)
fasd_cache="$HOME/.fasd-init-bash"
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias bash-hook bash-ccomp bash-ccomp-install >| "$fasd_cache"
fi
source "$fasd_cache"
unset fasd_cache
# Fasd extra alias
alias v='f -e vim' # quick opening files with vim
alias o='a -e xdg-open' # quick opening files with xdg-open

alias ls='ls --color=auto'
export VISUAL=vim
export EDITOR="$VISUAL"
PS1='[\u@\h \W]\$ '
