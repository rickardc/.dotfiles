{
  config,
  pkgs,
  ...
}: let
  tuigreetTheme = "border=magenta;text=cyan;prompt=green;time=red;action=blue;button=yellow;container=black;input=red";
  sway-session = "${pkgs.sway}/share/wayland-sessions";
in {
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${sway-session}  --theme ${tuigreetTheme}";
      user = "greeter";
    };
  };

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
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
    swayidle
    swaylock
    waybar
    wofi
    alacritty
    greetd.tuigreet
    wl-clipboard
    xwayland # Optional, for legacy X11 apps
  ];

  # Optional: give your user access to sway session and DRM
  users.users.chris.extraGroups = ["seat" "video"];

  # seatd gives DRM access without root
  services.seatd.enable = true;

  # Enable dbus (needed for some apps like Waybar, notifications)
  services.dbus.enable = true;

  systemd.user.services.swayidle = {
    enable = true;
  };

  # Set Wayland environment variables
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  # Ensure swaylock works
  security.pam.services.swaylock = {};

  #Use xdg-desktop-portal-wlr for Sway and Wayland-based environments.
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [xdg-desktop-portal-wlr];
    config.common.default = "*";
  };
}
