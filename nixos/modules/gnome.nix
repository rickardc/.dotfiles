# modules/gnome.nix
{
  config,
  pkgs,
  ...
}: {
  services.xserver = {
    enable = true;
    # Enable the GNOME Desktop Environment
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
    videoDrivers = ["amdgpu"];
    # Configure keymap in X11
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  services.accounts-daemon.enable = true;

  services.gnome = {
    gnome-online-accounts.enable = true;
    sushi.enable = true;
    gnome-settings-daemon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome-boxes
    gnome-shell-extensions
    gnome-software
    gnome-terminal
    gnomeExtensions.sermon
  ];

  environment.gnome.excludePackages = [
    pkgs.gnome-tour
  ];

  services.xserver.excludePackages = [
    pkgs.xterm
  ];
}
