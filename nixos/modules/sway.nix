{
  config,
  pkgs,
  ...
}: {
  # Enable greetd with tuigreet as the greeter
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
        user = "greeter";
      };
    };
  };

  # Create a greeter system user
  users.users.greeter = {
    isSystemUser = true;
    group = "greeter";
    home = "/var/lib/greetd";
    shell = pkgs.bash;
  };
  users.groups.greeter = {};

  # Set up Sway and basic Wayland apps
  environment.systemPackages = with pkgs; [
    sway
    waybar
    wofi
    alacritty
    greetd.tuigreet
    wl-clipboard
    xwayland # Optional, for legacy X11 apps
  ];

  # Optional: give your user access to sway session and DRM
  users.users.chris.extraGroups = ["seat" "video"]; # Replace with your username

  # seatd gives DRM access without root
  services.seatd.enable = true;

  # Enable dbus (needed for some apps like Waybar, notifications)
  services.dbus.enable = true;

  # Set Wayland environment variables
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Ensure swaylock works
  security.pam.services.swaylock = {};

  # Optional: fonts for UI polish
  fonts.packages = with pkgs; [dejavu_fonts noto-fonts];
}
