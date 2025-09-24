#!/bin/bash
# Auto-add external Btrfs drive to fstab on CachyOS with user ownership

set -e

MOUNTPOINT="/mnt/external"
USER_NAME=$(whoami)
USER_ID=$(id -u "$USER_NAME")
GROUP_ID=$(id -g "$USER_NAME")

echo ">>> Running as user: $USER_NAME (UID=$USER_ID, GID=$GROUP_ID)"

echo ">>> Detecting Btrfs partitions..."
lsblk -f | grep btrfs || { echo "No Btrfs partitions found."; exit 1; }

read -rp "Enter the UUID of your external Btrfs partition: " UUID

if [ -z "$UUID" ]; then
    echo "UUID cannot be empty!"
    exit 1
fi

echo ">>> Creating mountpoint at $MOUNTPOINT (if missing)..."
sudo mkdir -p "$MOUNTPOINT"

echo ">>> Setting ownership of mountpoint to $USER_NAME..."
sudo chown "$USER_NAME:$USER_NAME" "$MOUNTPOINT"

FSTAB_LINE="UUID=$UUID  $MOUNTPOINT  btrfs  defaults,nofail,noatime,compress=zstd:3  0  0"

# Check if already exists
if grep -q "$UUID" /etc/fstab; then
    echo ">>> Entry for UUID=$UUID already exists in /etc/fstab"
else
    echo ">>> Adding entry to /etc/fstab..."
    echo "$FSTAB_LINE" | sudo tee -a /etc/fstab
fi

echo ">>> Testing with mount -a..."
sudo mount -a

echo ">>> Fixing ownership of mounted filesystem..."
sudo chown -R "$USER_NAME:$USER_NAME" "$MOUNTPOINT"

echo ">>> Done! External Btrfs drive will auto-mount at boot with $USER_NAME ownership."
