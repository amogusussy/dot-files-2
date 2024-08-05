pipewire &
# exec qtile start
xset r rate 200 50 &
picom --config /home/matthew/.config/picom/picom.conf &
dbus-launch --sh-syntax --exit-with-session qtile start
# dbus-launch --sh-syntax --exit-with-session awesome
