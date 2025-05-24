{
  config,
  lib,
  pkgs,
  ...
}: let
  commonAliases = {
    ll = "ls -lah";
    vim = "nvim";
    cat = "bat";
    ff = "fastfetch";
    gs = "git status";
    gc = "git commit";
    gco = "git checkout";
    c = "clear";
    ".." = "cd ..";
  };
in {
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = commonAliases;

    shellInit = ''
      eval "$(oh-my-posh init zsh --config $HOME/.dotfiles/.config/ohmyposh/zen.toml)"
    '';
  };

  programs.bash = {
    #enable = true;  no longer used
    shellAliases = commonAliases;
  };
}
