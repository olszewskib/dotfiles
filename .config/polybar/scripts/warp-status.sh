#!/bin/bash

# Check if the script was called with a click argument
if [ "$1" == "click" ]; then
    warp_status=$(warp-cli status | awk '{print $3}')

    if [ "$warp_status" == "Connected" ]; then
        # If connected, disconnect
        warp-cli disconnect
    else
        # If disconnected, connect
        warp-cli connect
    fi
    exit 0
fi

# If no click argument, just display the current status
warp_status=$(warp-cli status | awk '{print $3}')

if [ "$warp_status" == "Connected" ]; then
    echo " WARP: Connected"
else
    echo " WARP: Disconnected"
fi
