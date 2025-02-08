#!/bin/sh
picom --config $HOME/.config/picom/picom.conf &

# Change long key press sensitivity. For vim.
xset r rate 200 50

sleep 2

if [[ "$(pactl get-default-sink)" == "reverse-stereo" ]]; then
    printf "Audio already reversed\n";
    return
fi;
sink_number="$(pactl list short sinks | grep "RUNNING" | awk '{print $1}')";
$output="$(pactl load-module module-remap-sink "sink_name=reverse-stereo" master="$sink_number" channels=2 master_channel_map=front-right,front-left channel_map=front-left,front-right)";
if [[ "$?" == "0" ]]; then
    pactl set-default-sink "reverse-stereo";
fi
