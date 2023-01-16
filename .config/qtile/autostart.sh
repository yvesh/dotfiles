#!/usr/bin/env bash

gnome-keyring-daemon --start &
picom &
# emacs --daemon &
~/.fehbg &
numlockx on &
dunst &
copyq &
xss-lock i3lock-fancy-rapid 3 5 &

