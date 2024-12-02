{pkgs, ...}: {
  enable = true;

  settings = {
    logo = {
      source = "NixOS";
      padding = {
        right = 1;
      };
    };

    modules = [
      "title"
      "separator"
      "os"
      "host"
      "kernel"
      "uptime"
      "packages"
      "shell"
      "display"
      "de"
      "wm"
      "wmtheme"
      #"theme"
      #"icons"
      #"font"
      #"cursor"
      "terminal"
      "terminalfont"
      "board"
      "bios"
      "cpu"
      "gpu"
      "memory"
      #"swap"
      "disk"
      "localip"
      "battery"
      "poweradapter"
      #"locale"
      "break"
      "colors"
    ];
  };
}
