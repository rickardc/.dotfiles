{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    air
    elixir
    cargo
    gcc
    gnumake
    go
    zulu #java
    julia
    lua
    lua51Packages.lua
    luajitPackages.luarocks
    nodejs_23
    php
    php82Packages.composer
    python3
    python312Packages.pip
    python312Packages.jupyter
    python312Packages.bluepy
    python312Packages.pybluez
    R
    vscode-langservers-extracted
  ];
}
