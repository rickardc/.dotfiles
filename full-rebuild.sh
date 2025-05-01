#!/usr/bin/env bash
set -x
pushd /home/chris/.dotfiles/nix || exit
alejandra . &>/dev/null
git add .
git diff -U0 ./*
echo "NixOS Rebuilding..."
sudo nix flake update
sudo nixos-rebuild switch --flake . | tee nixos-switch.log || (
 < nixos-switch.log grep --color error && false)
gen=$(nixos-rebuild list-generations | grep current)
echo "Generation: $gen"
git commit -am "$gen"
flatpak update
popd || exit
