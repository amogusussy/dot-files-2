#!/bin/sh
picom --config $HOME/.config/picom/picom.conf &

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
