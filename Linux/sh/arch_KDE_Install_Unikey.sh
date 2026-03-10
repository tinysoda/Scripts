#!/usr/bin/env fish

# Function to check if a command is installed
function command_exists
    type -q $argv[1]
end

# Install paru if not installed
if not command_exists paru
    echo "Installing paru..."
    sudo pacman -S --noconfirm paru
else
    echo "Paru already installed. Skipping installation."
end

# Install fcitx5 if not installed
if not command_exists fcitx5
    echo "Installing fcitx5..."
    sudo pacman -S fcitx5 fcitx5-qt fcitx5-gtk fcitx5-unikey kcm-fcitx5 --noconfirm
else 
    echo "fcitx5 already installed. Skipping installation."
end

# Add fcitx configurations to /etc/environment if not already added
if not grep -q "GTK_IM_MODULE=fcitx" /etc/environment
    echo "Adding fcitx configurations to /etc/environment..."
    echo 'GTK_IM_MODULE=fcitx' | sudo tee -a /etc/environment > /dev/null
    echo 'QT_IM_MODULE=fcitx' | sudo tee -a /etc/environment > /dev/null
    echo 'XMODIFIERS=@im=fcitx' | sudo tee -a /etc/environment > /dev/null
else
    echo "fcitx configurations already present in /etc/environment. Skipping addition."
end
