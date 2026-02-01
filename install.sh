#!/bin/bash

SYSTEM_MODEL="$HOME/.config/christian-mangowc-noctalia-system-model.kdl"
QUICKSHELL_DIR="$HOME/.config/quickshell"
NOCTALIA_DIR="$HOME/.config/noctalia"
FONT_DIR="$HOME/.local/share/fonts"
THEME_DIR="$HOME/.themes"

mkdir -p "$QUICKSHELL_DIR" "$FONT_DIR" "$THEME_DIR" "$NOCTALIA_DIR"

echo "Starting user configuration setup..."

if [ ! -d "$QUICKSHELL_DIR/noctalia-shell" ]; then
    echo "Fetching latest release of Noctalia-shell..."
    RELEASE_URL=$(curl -s https://api.github.com/repos/noctalia-dev/noctalia-shell/releases/latest | grep "tarball_url" | cut -d '"' -f 4)
    if [ -z "$RELEASE_URL" ]; then
        echo "Error: Could not find the latest release URL."
        exit 1
    fi
    mkdir -p "$QUICKSHELL_DIR/noctalia-shell"
    curl -L "$RELEASE_URL" | tar -xz -C "$QUICKSHELL_DIR/noctalia-shell" --strip-components=1
    echo "Noctalia-shell installed from release."
else
    echo "Noctalia-shell directory already exists. Skipping download."
fi

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    echo "Downloading JetBrains Mono Nerd Font..."
    TEMP_FONT_DIR=$(mktemp -d)
    curl -fLo "$TEMP_FONT_DIR/JetBrainsMono.zip" https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip
    unzip "$TEMP_FONT_DIR/JetBrainsMono.zip" -d "$FONT_DIR"
    fc-cache -fv
    rm -rf "$TEMP_FONT_DIR"
else
    echo "JetBrains Mono Nerd Font already installed."
fi

if [ ! -d "$THEME_DIR/adw-gtk3" ]; then
    echo "Downloading adw-gtk3 theme..."
    THEME_URL=$(curl -s https://api.github.com/repos/lassekongo83/adw-gtk3/releases/latest | grep "browser_download_url.*tar.xz" | cut -d '"' -f 4)
    curl -L "$THEME_URL" | tar -xJ -C "$THEME_DIR"
else
    echo "adw-gtk3 theme already exists."
fi

echo "Sync packages from system model..."
sudo moss sync --import $SYSTEM_MODEL

echo "Setup complete!"
