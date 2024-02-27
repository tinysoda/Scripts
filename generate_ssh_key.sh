#!/bin/bash

# Script to generate SSH key and display the public key

# Set the email address
email="rainguy.shy@gmail.com"
user="tinysoda"

# Generate SSH key
ssh-keygen -o -t rsa -C "$email"

# Display the public key
cat ~/.ssh/id_rsa.pub
