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
}
