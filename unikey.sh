#!/bin/bash

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "Error: yay is not installed. Please install yay first."
    exit 1
fi

# Install pamac-aur-git using yay
yay -S --noconfirm pamac-aur-git

# Check if the installation was successful
if [ $? -eq 0 ]; then
    echo "pamac-aur-git has been successfully installed."
else
    echo "Error: Installation of pamac-aur-git failed."
    exit 1
fi

# Install ibus
sudo pamac install --no-confirm ibus

# Build ibus-bamboo
pamac build --no-confirm ibus-bamboo

# Add ibus configurations to /etc/profile
sudo bash -c 'cat <<EOL >> /etc/profile
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
ibus-daemon -drx
EOL'
