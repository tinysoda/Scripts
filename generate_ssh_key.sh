#!/bin/bash

# Script to generate SSH key and display the public key

# Set the email address
email="rainguy.shy@gmail.com"
user="tinysoda"

# Generate SSH key
ssh-keygen -o -t rsa -C "$email"

# Display the public key
cat ~/.ssh/id_rsa.pub

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
