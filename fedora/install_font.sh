#!/usr/bin/env bash

# Script to download and install Fira Code Nerd Font

set -euo pipefail # Exit on error, unset variable, or pipeline failure

FONT_DIR="$HOME/.local/share/fonts"
FONT_ARCHIVE="FiraCode.tar.xz"
FONT_NAME_BASE="FiraCode" # Base name for potential unzipping

echo "Installing Fira Code Nerd Font..."

# Create the fonts directory if it doesn't exist
echo "Creating fonts directory: $FONT_DIR"
mkdir -p "$FONT_DIR"

# Navigate to the fonts directory
echo "Changing directory to: $FONT_DIR"
cd "$FONT_DIR"

# Download the Fira Code Nerd Font archive
echo "Downloading $FONT_ARCHIVE..."
if curl -o "$FONT_ARCHIVE" -L https://github.com/ryanoasis/nerd-fonts/releases/latest/download/"$FONT_ARCHIVE"; then
  echo "Successfully downloaded $FONT_ARCHIVE"
else
  echo "Error: Failed to download $FONT_ARCHIVE"
  exit 1
fi

# Extract the font files
echo "Extracting font files from $FONT_ARCHIVE..."
if tar -xf "$FONT_ARCHIVE"; then
  echo "Successfully extracted font files."
else
  echo "Error: Failed to extract font files from $FONT_ARCHIVE"
  exit 1
fi

# Remove the archive file
echo "Cleaning up: removing $FONT_ARCHIVE"
rm "$FONT_ARCHIVE"

# Update the font cache
echo "Updating font cache..."
fc-cache -fv

echo "Fira Code Nerd Font installed successfully!"
echo "You may need to restart your terminal or font-dependent applications."