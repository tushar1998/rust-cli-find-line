#!/bin/bash

# Define the URL to your zipped binary on GitHub Releases
BINARY_URL="https://github.com/tushar1998/rust-cli-find-line/releases/download/v0.0.1-dev.3/findline"
INSTALL_PATH="/usr/local/bin/findline"

echo "Downloading findline..."
curl -L $BINARY_URL -o $INSTALL_PATH

if [ $? -ne 0 ]; then
    echo "Failed to download the binary. Please check the URL and network connection."
    exit 1
fi

echo "Setting executable permissions..."
chmod +x $INSTALL_PATH

if [[ -f "$INSTALL_PATH" ]]; then
    echo "Installation successful, your-app is now available."
else
    echo "Installation failed. The binary could not be installed."
fi