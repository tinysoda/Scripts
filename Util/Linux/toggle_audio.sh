#!/bin/bash

# Define your device names
SPEAKERS="bluez_output.40_72_18_76_D6_84.1"
HEADPHONES="alsa_output.usb-Logitech_G733_Gaming_Headset-00.analog-stereo"

# Get the name of the current default sink
CURRENT_SINK=$(pactl get-default-sink)

if [[ "$CURRENT_SINK" == *"$SPEAKERS"* ]]; then
    echo "Switching to Headphones"
    pactl set-default-sink "$HEADPHONES"
else
    echo "Switching to Speakers"
    pactl set-default-sink "$SPEAKERS"
fi
