{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.neovim = {
    enable = true;
    configure = ''
      set number
      set relativenumber
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set mouse=a
      syntax on
      colorscheme gruvbox
    '';
  };
}
