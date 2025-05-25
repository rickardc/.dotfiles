{
  config,
  pkgs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    zsh
    fish
    git
    gh
    xfce.thunar
    stow
    alacritty
    btop

    bat # better cat
    ripgrep # fast grep alternative
    fd # modern find
    htop # system monitor
    tree # directory tree view
    tmux # terminal multiplexer
    pavucontrol

    unzip
    curl
    wget
    inetutils
    nmap
    zip
    p7zip
  ];
}
