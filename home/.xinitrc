#!/bin/bash

if [ -d /etc/X11/xinit/xinitrc.d ]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# caps lock -> esc
xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'

exec startxfce4
