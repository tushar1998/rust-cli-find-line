#!/bin/bash

update_path() {
    local profile_file="$1"
    if [ -f "$profile_file" ] && ! grep -qx 'export PATH="$HOME/bin:$PATH"' "$profile_file"; then
        echo 'export PATH="$HOME/bin:$PATH"' >> "$profile_file"
        echo "Updated $profile_file with PATH settings."
    fi
}

# Define the URL to your zipped binary on GitHub Releases
BINARY_URL="https://github.com/tushar1998/rust-cli-find-line/releases/download/v0.1.0-dev.2/findline"
INSTALL_PATH="/Users/$USER/bin"
BIN_NAME="findline"
OS="$(uname -s)"
ARCH="$(uname -m)"

echo "Downloading findline..."
curl -L $BINARY_URL -o "$INSTALL_PATH/$BIN_NAME"

mkdir $INSTALL_PATH

echo "Setting executable permissions..."
chmod +x "$INSTALL_PATH/$BIN_NAME"

update_path "$HOME/.bashrc"
update_path "$HOME/.zshrc"

if [[ -f "$INSTALL_PATH/$BIN_NAME" ]]; then
    echo "Installation successful, findline is now available."
else
    echo "Installation failed. Please check permissions and internet connection."
fi