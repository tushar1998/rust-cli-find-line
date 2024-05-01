#!/bin/bash

# Define the URL to your zipped binary on GitHub Releases
BINARY_URL="https://github.com/tushar1998/rust-cli-find-line/releases/download/v0.0.1-dev.7/findline"
INSTALL_PATH="/usr/local/bin"
BIN_NAME="findline"

echo "Downloading findline..."
sudo curl -L $BINARY_URL -o "$INSTALL_PATH/$BIN_NAME"

echo "Setting executable permissions..."
sudo chmod +x "$INSTALL_PATH/$BIN_NAME"

if [[ -f "$INSTALL_PATH/$BIN_NAME" ]]; then
    echo "Installation successful, your-app is now available."
else
    echo "Installation failed. Please check permissions and internet connection."
fi