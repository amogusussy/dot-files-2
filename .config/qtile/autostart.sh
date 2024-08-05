#!/bin/sh

# Kill redshift for when reloading the config.
# pkill redshift;
# redshift -l 52.3:1.5 &

# Reverse audio.
pactl load-module module-remap-sink \
  sink_name=reverse-stereo \
  master=0 \
  channels=2 \
  master_channel_map=front-right,front-left \
  channel_map=front-left,front-right
pactl set-default-sink reverse-stereo

# Change long key press sensitivity. For vim.
xset r rate 200 50
