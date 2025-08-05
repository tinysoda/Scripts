#!/bin/bash

# A shell script to install and set up Plex Media Server on Arch Linux

# --- 1. Check for root privileges ---
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root."
   exit 1
fi

echo "Starting Plex Media Server installation and setup on Arch Linux..."

# --- 2. Update the system ---
echo "Updating system..."
paru -Syu --noconfirm

# --- 3. Install Plex Media Server from AUR ---
echo "Installing plex-media-server from AUR using paru..."
if ! command -v paru &> /dev/null
then
    echo "paru could not be found. Please install paru (or another AUR helper) first."
    exit 1
fi
paru -S --noconfirm plex-media-server

# --- 4. Create and configure a user and group ---
echo "Creating plex user and group and setting up permissions..."
# Check if the 'plex' user already exists
if ! id "plex" &>/dev/null; then
    useradd -r -s /bin/false -G audio,video,plex -U plex
    echo "Plex user and group created."
else
    echo "Plex user already exists. Skipping user creation."
fi

# --- 5. Set up the media directory ---
MEDIA_DIR="/srv/media"
echo "Creating media directory at $MEDIA_DIR and setting permissions..."
mkdir -p "$MEDIA_DIR"

# Set ownership to the plex user and group
chown -R plex:plex "$MEDIA_DIR"

# Set permissions to allow the plex user to read and write
chmod -R 755 "$MEDIA_DIR"

# Add the root user to the plex group to easily manage files
usermod -a -G plex root

echo "Media directory $MEDIA_DIR created and configured."

# --- 6. Configure Plex to use the new user ---
echo "Configuring Plex to run as the 'plex' user..."
CONFIG_FILE="/usr/lib/systemd/system/plexmediaserver.service"
if [ -f "$CONFIG_FILE" ]; then
    # Use sed to change the user and group
    sed -i 's/^User=.*/User=plex/' "$CONFIG_FILE"
    sed -i 's/^Group=.*/Group=plex/' "$CONFIG_FILE"
    echo "Plex service file updated to run as user 'plex'."
else
    echo "Warning: Plex service file not found at $CONFIG_FILE. Manual configuration may be required."
fi

# Reload systemd daemon to recognize changes
systemctl daemon-reload

# --- 7. Enable and start the Plex service ---
echo "Enabling and starting the Plex Media Server service..."
systemctl enable plexmediaserver.service
systemctl start plexmediaserver.service

# Check the status of the service
if systemctl is-active --quiet plexmediaserver.service; then
    echo "Plex Media Server service is running successfully."
else
    echo "Error: Plex Media Server service failed to start. Please check the logs with 'journalctl -u plexmediaserver.service'."
    exit 1
fi

# --- 8. Display success message ---
echo "--------------------------------------------------------"
echo "Plex Media Server installation and setup is complete!"
echo "Please proceed with the initial setup via the web interface."
echo "You can access Plex at: http://<YourServerIP>:32400/web"
echo "You may need to ssh tunnel if accessing from a different machine:"
echo "ssh root@<YourServerIP> -L 8888:localhost:32400"
echo "Then, open http://localhost:8888/web in your browser."
echo "--------------------------------------------------------"

exit 0
