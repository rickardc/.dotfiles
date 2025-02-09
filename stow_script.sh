#!/usr/bin/env bash

#stow --dir=./.config --target=$HOME/.config

for package in .config/*/; do  # Iterate over all directories (packages)
  package="${package%/}"  # Remove the trailing slash
  package="${package##*/}" # Remove the leading path
  stow --dir=".config" --target="$HOME/.config" "$package" # Stow each package

done

