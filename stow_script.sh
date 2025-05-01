#!/usr/bin/env bash

#stow --dir=./.config --target=$HOME/.config

stow --target="$HOME/.config" .config 
stow --target="$HOME" home 
