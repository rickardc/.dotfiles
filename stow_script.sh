#!/usr/bin/env bash

#stow --dir=./.config --target=$HOME/.config

stow --adopt --target="$HOME/.config" .config # Stow each package

