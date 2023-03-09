#!/bin/bash

/usr/bin/supervisord -c /system/conf.d/supervisord.conf &

cd /usr/share/novnc/utils
./launch.sh --vnc localhost:5900 &
cd /

export DISPLAY=:0
Xvfb :0 -screen 0 1024x768x16 &
sleep 5
x11vnc -display :0 -noxdamage -wait 5 -shared -nopw -forever &
xfce4-session &
dbus-launch --exit-with-session gnome-session &

# Keep the script running to prevent container exit
tail -f /dev/null
