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
    fd
    fzf
    git
    gh
    htop
    inetutils
    nmap
    p7zip
    ripgrep
    stow
    tmux
    tree
    unzip
    wget
    zip

    ### Applications (GUI)

    librewolf # web browser
    pavucontrol # audio control
    vscodium # code editor
    xfce.thunar # file manager
  ];
}
