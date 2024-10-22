#!/bin/bash

# Get battery percentage
battery_percentage=$(cat /sys/class/power_supply/BAT0/capacity)

# Get charging status (Charging/Discharging/Full)
battery_status=$(cat /sys/class/power_supply/BAT0/status)

# Display different icons and statuses based on the battery status and percentage
if [ "$battery_status" == "Charging" ]; then
    echo " $battery_percentage%"
elif [ "$battery_status" == "Full" ]; then
    echo " $battery_percentage%"
else
    if [ "$battery_percentage" -ge 80 ]; then
        echo " $battery_percentage%"
    elif [ "$battery_percentage" -ge 40 ]; then
        echo " $battery_percentage%"
    elif [ "$battery_percentage" -ge 20 ]; then
        echo " $battery_percentage%"
    else
        echo " $battery_percentage% (Low)"
    fi
fi

