# modules/gnome.nix
{
  config,
  pkgs,
  ...
}: {
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];

  # Enable the GNOME Desktop Environment
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Optional: Touchpad (commented because GNOME handles it)
  # services.xserver.libinput.enable = true;
}
