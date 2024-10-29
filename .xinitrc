sleep 3

pipewire &
pulseaudio &
xset r rate 200 50 &
picom --config $HOME/.config/picom/picom.conf &
dbus-launch --sh-syntax --exit-with-session qtile start
