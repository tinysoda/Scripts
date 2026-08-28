#!/usr/bin/env bash
if command -v spotify >/dev/null 2>&1 && command -v zip >/dev/null 2>&1; then
    echo "Spotify and zip are already installed. Skipping installation."
else
    echo "Spotify or zip is missing. Installing..."
    paru -Sy spotify zip --noconfirm
fi

curl -sSL https://spotx-official.github.io/run.sh | bash
