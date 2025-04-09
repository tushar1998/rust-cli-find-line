#!/bin/bash

set -e

REPO_OWNER="tushar1998"
REPO_NAME="rust-cli-find-line"
INSTALL_DIR="$HOME/bin"

# Detect OS and architecture
OS="$(uname -s)"
ARCH="$(uname -m)"

case "$OS" in
    Linux)
        case "$ARCH" in
            x86_64) TARGET="x86_64-unknown-linux-gnu" ;;
            aarch64) TARGET="aarch64-unknown-linux-gnu" ;;
            *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
        esac
        ;;
    Darwin)
        case "$ARCH" in
            x86_64) TARGET="x86_64-apple-darwin" ;;
            arm64) TARGET="aarch64-apple-darwin" ;;
            *) echo "Unsupported architecture: $ARCH"; exit 1 ;;
        esac
        ;;
    *)
        echo "Unsupported OS: $OS"
        exit 1
        ;;
esac

# Fetch latest release
LATEST_RELEASE=$(curl -s https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/releases/latest | grep "browser_download_url" | grep "$TARGET" | cut -d '"' -f 4)

if [ -z "$LATEST_RELEASE" ]; then
    echo "Failed to find a compatible release for target $TARGET."
    exit 1
fi

echo "Downloading $LATEST_RELEASE..."
curl -L "$LATEST_RELEASE" -o "findline-$TARGET.tar.gz"

echo "Extracting binary..."
tar -xzvf "findline-$TARGET.tar.gz"
chmod +x "findline-$TARGET"

# Move binary to install directory
echo "Installing findline to $INSTALL_DIR..."
mkdir -p "$INSTALL_DIR"

# Move and rename to findline
mv "findline-$TARGET" "$INSTALL_DIR/findline" 

# Add ~/bin to PATH if not already added
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "export PATH=\"$HOME/bin:\$PATH\"" >> "$HOME/.bashrc"
    echo "export PATH=\"$HOME/bin:\$PATH\"" >> "$HOME/.zshrc"
    export PATH="$HOME/bin:$PATH"
    echo "Added $HOME/bin to PATH. Restart your terminal or run 'source ~/.bashrc' (or 'source ~/.zshrc' for zsh)."
fi

echo "Installation complete! Run 'findline --help' to verify."