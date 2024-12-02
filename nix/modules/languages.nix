{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    air
    elixir
    gcc
    gnumake
    php
    python3
    R
    vscode-langservers-extracted
  ];
}
