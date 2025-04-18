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

VERSION=$(echo "$LATEST_RELEASE" | grep -oE 'v[0-9]+(\.[0-9]+)*')

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

rm -rf findline-$TARGET.tar.gz

# Add ~/bin to PATH if not already added
if [[ ":$PATH:" != *":$HOME/bin:"* ]]; then
    echo "Adding $HOME/bin to PATH..."
    SHELL_PROFILE=""
    if [ -n "$BASH_VERSION" ] && [ -f "$HOME/.bashrc" ]; then
        SHELL_PROFILE="$HOME/.bashrc"
    elif [ -n "$ZSH_VERSION" ] && [ -f "$HOME/.zshrc" ]; then
        SHELL_PROFILE="$HOME/.zshrc"
    elif [ -f "$HOME/.profile" ]; then
        SHELL_PROFILE="$HOME/.profile"
    fi

    if [ -n "$SHELL_PROFILE" ]; then
        echo "export PATH=\"$HOME/bin:\$PATH\"" >> "$SHELL_PROFILE"
        echo "Added to \$SHELL_PROFILE ($SHELL_PROFILE). Restart your shell or run 'source $SHELL_PROFILE'."
    else
        echo "Warning: Couldn't detect shell config file. Add this line manually to your shell profile:"
        echo "export PATH=\"$HOME/bin:\$PATH\""
    fi
    export PATH="$HOME/bin:$PATH"
fi

# Installation Tracking / Monitoring
if [ "$OS" = "Darwin" ]; then
    # macos
    DISTRO=$(sw_vers -productName)" "$(sw_vers -productVersion)
elif [ -f /etc/os-release ]; then
    # Linux
    DISTRO=$(grep "^PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"')
else
    DISTRO="Unknown"
fi

USER_AGENT="Findline-Installer/1.0 ($OS; $ARCH; $DISTRO)" 

curl --silent --output /dev/null --location 'https://findline-rust.mistry-tushar98.workers.dev/installs' \
  --header 'Content-Type: application/json' \
  --data "$(cat <<EOF
{
  "os": "$OS",
  "arch": "$ARCH",
  "target": "$TARGET",
  "version": "$VERSION",
  "user_agent": "$USER_AGENT"
}
EOF
)"

echo "Installation complete! Run 'findline --help' to verify."