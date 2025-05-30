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

  imports = [
    ./obsidian.nix
  ];
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  programs = {
    alacritty = import ./alacritty.nix {inherit config pkgs inputs;};
    bash = import ./bash.nix {inherit pkgs;};
    fastfetch = import ./fastfetch.nix {inherit pkgs;};
    fzf = import ./fzf.nix {inherit pkgs;};
    git = import ./git.nix {inherit pkgs;};
    neovim = import ./neovim.nix {inherit pkgs;};
    tmux = import ./tmux.nix {inherit pkgs;};
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
      gtk-application-prefer-system-theme = true;
    };
  };

  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-system";
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
