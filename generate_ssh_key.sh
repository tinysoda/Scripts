#!/bin/bash

# Script to configure Git, generate SSH key, display the public key, and open GitHub SSH keys settings page

# Set the email address and username
email="rainguy.shy@gmail.com"
user="tinysoda"

# Configure Git
echo "Configuring Git with username and email..."
git config --global user.name "$user"
git config --global user.email "$email"
echo "Git configured."

# Define the default file for the SSH key
KEY_FILE="$HOME/.ssh/id_rsa"

# Check if the SSH key already exists
if [ -f "$KEY_FILE" ]; then
  echo "An SSH key already exists at $KEY_FILE."
  echo "Here is the public key:"
else
  # Generate a new SSH key
  ssh-keygen -o -t rsa -b 4096 -C "$email" -f "$KEY_FILE" -N ""
  echo "SSH key generated."
fi

# Display the public key
cat "${KEY_FILE}.pub"

# Open the browser and go to GitHub SSH keys settings page
if command -v xdg-open &> /dev/null; then
  xdg-open https://github.com/settings/keys
elif command -v gnome-open &> /dev/null; then
  gnome-open https://github.com/settings/keys
elif command -v open &> /dev/null; then
  open https://github.com/settings/keys
else
  echo "Please open the following URL in your browser to add your new SSH key:"
  echo "https://github.com/settings/keys"
fi
