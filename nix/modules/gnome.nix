{pkgs, ...}: {
  services.accounts-daemon.enable = true;

  services.gnome = {
    gnome-online-accounts.enable = true;
    sushi.enable = true;
    gnome-settings-daemon.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnome.gnome-boxes
    gnome.gnome-shell-extensions
    gnome.gnome-software
    gnome.gnome-terminal
    gnomeExtensions.window-calls
    gnomeExtensions.wallpaper-switcher
  ];

  environment.gnome.excludePackages = [
    pkgs.gnome-tour
  ];

  services.xserver.excludePackages = [
    pkgs.xterm
  ];
}
