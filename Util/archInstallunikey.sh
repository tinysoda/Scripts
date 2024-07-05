#!/bin/bash

# Function to check if a command is installed
command_exists() {
    command -v "$1" &> /dev/null
}

# Install yay if not installed
if ! command_exists yay; then
    echo "Installing yay..."
    sudo pacman -S --noconfirm yay
fi

if ! command_exists ibus-bamboo; then
    echo "Building ibus-bamboo..."
    yay -S --noconfirm ibus-bamboo
else
    echo "ibus-bamboo is already installed. Skipping build."
fi

# Add ibus configurations to /etc/profile if not already added
if ! grep -q "export GTK_IM_MODULE=ibus" /etc/profile; then
    echo "Adding ibus configurations to /etc/profile..."
    sudo bash -c 'cat <<EOL >> /etc/profile
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
ibus-daemon -drx
EOL'
else
    echo "ibus configurations already present in /etc/profile. Skipping addition."
fi
