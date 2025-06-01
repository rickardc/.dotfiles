{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.bat = {
    enable = true;
    extraPackages = with pkgs.bat-extras; [
      batdiff
      batman
      prettybat
    ];

    settings = {
      italic-text = "always";
      # map-syntax = [
      #   "*.ino:C++"
      #   ".ignore:Git Ignore"
      # ];
      pager = "less";
      #paging = "never";
      theme = "TwoDark";
    };
  };

  programs._1password-gui.polkitPolicyOwners = ["chris"];

  programs.nano = {
    enable = true;
    syntaxHighlight = true;
    nanorc = ''
      set linenumbers
      set mouse
      set tabstospaces
      set tabsize 4
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    flags = [
      "--cmd cd"
    ];
  };
}
