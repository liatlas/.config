#!/bin/bash

# Cache the max brightness once (only needed the first time)
if [ ! -f /tmp/max_brightness ]; then
    brightnessctl m > /tmp/max_brightness
fi

# Get the current brightness level as a percentage
brightness=$(brightnessctl g)
max_brightness=$(cat /tmp/max_brightness)

# Calculate the percentage
percentage=$((brightness * 100 / max_brightness))

# Display the percentage to i3blocks
echo "☀︎ $percentage%"

