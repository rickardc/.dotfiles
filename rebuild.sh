#!/usr/bin/env bash

git add .
sudo nixos-rebuild switch --flake ./nix

# List of Flatpak apps to check (one per line)
apps=(
    "org.mozilla.firefox"
    "com.bitwarden.desktop"
)

for app in "${apps[@]}"; do
    if flatpak info $app &>/dev/null; then
      continue
    else
        echo "$app is not installed. Installing..."
        flatpak install flathub $app
    fi
done

flatpak update
