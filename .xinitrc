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

xrandr --output DisplayPort-0 --mode 2560x1440 --rate 165.08
xrandr --output DisplayPort-2 --mode 2560x1440 --rate 170.00

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
        # sleep 120s && noisetorch -i 2> /dev/null &
        flashfocus 2> /dev/null &
        # sxhkd -c ~/.config/dk/sxhkdrc & ##not needed?##
        exec dk;;
# No known session, try to run it as command
    *   )
        exec $1;;
esac
