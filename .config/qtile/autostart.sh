#!/bin/sh

# Kill redshift for when reloading the config.
# pkill redshift;
# redshift -l 52.3:1.5 &

# pkill pulseaudio
# pkill pipewire

pipewire &
pulseaudio &
picom --config $HOME/.config/picom/picom.conf &

xrandr --output DVI-D-0 --off --output HDMI-0 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-0 --off --output DP-1 --off --output DP-2 --mode 1920x1080 --pos 1920x0 --rotate normal --output DP-3 --off --output DP-4 --off --output DP-5 --off

# Change long key press sensitivity. For vim.
xset r rate 200 50

sleep 2
# Reverse audio.
pactl load-module module-remap-sink \
  sink_name=reverse-stereo \
  master=1 \
  channels=2 \
  master_channel_map=front-right,front-left \
  channel_map=front-left,front-right
pactl set-default-sink reverse-stereo
