{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.packages = with pkgs; [
    fastfetch
    btop
    discord
    glib
    #vesktop
    signal-desktop
    _1password-gui
    unstable.zed-editor
    solaar
    vlc
    gsettings-desktop-schemas
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    GSETTINGS_SCHEMA_DIR = "${pkgs.glib}/share/glib-2.0/schemas";
  };

  programs = {
    alacritty = import ./alacritty.nix {inherit config pkgs inputs;};
    bash = import ./bash.nix {inherit pkgs;};
    fastfetch = import ./fastfetch.nix {inherit pkgs;};
    fzf = import ./fzf.nix {inherit pkgs;};
    git = import ./git.nix {inherit pkgs;};
    neovim = import ./neovim.nix {inherit pkgs;};
    tmux = import ./tmux.nix {inherit pkgs;};
    # vscode = import ./vscode.nix {inherit pkgs;};
    zoxide = import ./zoxide.nix {inherit pkgs;};
    zsh = import ./zsh.nix {inherit config pkgs lib;};
  };

  home.file."${config.xdg.configHome}/nvim" = {
    source = ../../.config/nvim;
    recursive = true;
  };

  xdg = {
    enable = true;
  };

  gtk = {
    enable = true;
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  home.activation = {
    set-gnome-background = pkgs.lib.mkAfter ''
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.background picture-uri '$HOME/github/nixos/wallpapers/abstract.png'
      ${pkgs.glib}/bin/gsettings set org.gnome.desktop.background picture-options 'zoom'
    '';
  };

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
