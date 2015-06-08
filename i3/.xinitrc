#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# Set my layout before starting the WM
# en_US int sorting without deadkeys and swap caps<->escape
setxkbmap -layout us -variant altgr-intl -option nodeadkeys -option "caps:swapescape"
exec i3
