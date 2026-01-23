#!/bin/bash

# Function to get Bluetooth ID for device name
get_bluetooth_id() {
    local device_name="$1"
    local bluetooth_id=$(bluetoothctl devices | grep "$device_name" | cut -d ' ' -f 2)
    echo "$bluetooth_id"
}

# Check if MX-T40 exists and set its ID, otherwise use default
DEVICE_NAME="[AV] MX-T40"
BLUETOOTHID=$(get_bluetooth_id "$DEVICE_NAME")

if [ -z "$BLUETOOTHID" ]; then
    BLUETOOTHID="40:72:18:76:D6:84"  # Default ID if device not found
    echo ">>> Device $DEVICE_NAME not found, using default ID"
else
    echo ">>> Found $DEVICE_NAME device"
fi

echo ">>> Starting Bluetooth connection to device $BLUETOOTHID..."
bluetoothctl connect "$BLUETOOTHID"

echo ">>>   Starting Syncthing service..."
syncthing
