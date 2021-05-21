#!/bin/sh

# https://github.com/arcolinux/arcolinux-dwm/blob/master/etc/skel/.config/arco-dwm/autostart.sh

run() {
	if ! pgrep "$1"; then
		"$@"&
	fi
}

run mpd
run dunst
run picom
run flashfocus
(sleep 1s && run mpd-mpris) # needed to properly autostart



# OLD
#[ -z "$(pgrep -f dunst)" ] && dunst &
#[ -z "$(pgrep -f picom)" ] && picom --experimental-backend &
#[ -z "$(pgrep -f flashfocus)" ] && flashfocus &