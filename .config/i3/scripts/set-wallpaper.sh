#!/bin/bash

# Terminate already running feh instances
killall -q feh

# Wait until the processes have been shut down
while pgrep -u $UID -x feh >/dev/null; do sleep 1; done

# Set a random wallpaper
feh --randomize --bg-scale ~/Pictures/Wallpapers/*
