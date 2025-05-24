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
      map-syntax = [
        "*.ino:C++"
        ".ignore:Git Ignore"
      ];
      #pager = "less --quit-if-one-screen --mouse";
      paging = "never";
      theme = "TwoDark";
    };
  };
}
