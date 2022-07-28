#!/bin/bash
xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60.00 --right-of DisplayPort-0
sleep 1
sed -i "s/#	 mon1='DisplayPort-0'/	 mon1='DisplayPort-0'/g
s/#	 mon2='HDMI-A-0'/	 mon2='HDMI-A-0'/g
s/#	 dkcmd set static_ws=true /	 dkcmd set static_ws=true /g
55s/#	 	ws=1  mon=$mon1/	 	ws=1  mon=$mon1/
56s/#	 	ws=2  mon=$mon1/	 	ws=2  mon=$mon1/
57s/#	 	ws=3  mon=$mon1/	 	ws=3  mon=$mon1/
58s/#	 	ws=4  mon=$mon2/	 	ws=4  mon=$mon2/
59s/#	 	ws=5  mon=$mon2/	 	ws=5  mon=$mon2/
60s/#	 	ws=6  mon=$mon2/	 	ws=6  mon=$mon2/
61s/#	 	ws=7  mon=$mon2/	 	ws=7  mon=$mon2/
62s/#	 	ws=8  mon=$mon2/	 	ws=8  mon=$mon2/
63s/#	 	ws=9  mon=$mon2/	 	ws=9  mon=$mon2/
64s/#	 	ws=10 mon=$mon2/	 	ws=10 mon=$mon2/" ~/.config/dk/dkrc
sleep 2
dkcmd restart
