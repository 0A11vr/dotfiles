#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00 
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60.00 

xsetroot -cursor_name left_ptr &
numlockx &
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
#hsetroot -solid "#303030" &
hsetroot -solid "#636161" &

session=${1:-2bwm}
case $session in
    2bwm)	
	        #exec dbus-run-session -- 2bwm;;
		2bwm;;
    sowm) 	sxhkd -c ~/.config/sowm/sowmrc &
		exec sowm;;
    # No known session, try to run it as command
    *   )       
    		exec $1;;
esac
