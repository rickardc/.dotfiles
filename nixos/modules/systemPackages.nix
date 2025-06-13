{
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    ### CLI Utilities

    # Shells
    fish
    zsh

    # Terminal tools
    alacritty
    bat
    btop
    curl
    corefonts
    fd
    file
    fzf
    gcc
    git
    gh
    htop
    inetutils
    man-pages
    nmap
    p7zip
    ripgrep
    stow
    sysbench
    tmux
    tree
    unzip
    wget
    zip
    lact
    ### Applications (GUI)

    darktable
    librewolf # web browser
    pavucontrol # audio control
    vscodium # code editor
    xfce.thunar # file manager

    _1password-cli
    _1password-gui
  ];
}
