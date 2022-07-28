#!/bin/sh

/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources

xrandr --output DisplayPort-0 --mode 1920x1080 --rate 144.00
#xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60.00

#xsettingsd & is this still needed
xsetroot -cursor_name left_ptr &
numlockx &

session=${1:-dk}
case $session in
    2bwm)
        #exec dbus-run-session -- 2bwm;;
        #hsetroot -solid "#303030" &
        #hsetroot -solid "#636161" &
        #sxhkd -c ~/.config/sxhkd/2bhkdrc &
        hsetroot -cover Pictures/oMuGsZb.jpg &
        picom -b 2> /dev/null &
        dunst &
        noisetorch -i 2> /dev/null &
        flashfocus 2> /dev/null &
        exec 2bwm;;
    openbox)
        exec openbox-session;;
    bspwm)
        hsetroot -cover Pictures/oMuGsZb.jpg &
        picom -b 2> /dev/null &
        dunst &
        noisetorch -i 2> /dev/null &
        flashfocus 2> /dev/null &
        sxhkd &
        exec bspwm;;
    dk)
        hsetroot -cover Pictures/oMuGsZb.jpg &
        picom -b 2> /dev/null &
        dunst &
        noisetorch -i 2> /dev/null &
        flashfocus 2> /dev/null &
        # sxhkd -c ~/.config/dk/sxhkdrc & ##not needed?##
        exec dk;;
# No known session, try to run it as command
    *   )
        exec $1;;
esac

