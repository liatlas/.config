#!/bin/bash
# Checks Caps Lock state and outputs for i3blocks

CAPS_STATE=$(xset q | grep "Caps Lock:" | awk '{print $4}') # 'on' or 'off'

if [ "$CAPS_STATE" = "on" ]; then
    echo "CAPS" # Text to display
    echo "#FF0000" # Color (Red for on)
    echo "1" # Instance (optional)
else
    echo "" # Blank text
    echo "#FFFFFF" # Color (White/default for off)
    echo "1" # Instance (optional)
fi

