{
  config,
  pkgs,
  ...
}: {
  programs.sway = {
    enable = true;
    xwayland.enable = true;
    extraPackages = with pkgs; [
      brightnessctl
      grim
      swayidle
      swaylock
      waybar
      wofi
      wl-clipboard
    ];
  };

  # systemd.user.services.swayidle = {
  #   enable = true;
  #   script = ''
  #     exec ${pkgs.swayidle}/bin/swayidle \
  #       timeout 300 '${pkgs.swaylock}/bin/swaylock -f -c 000000' \
  #       timeout 600 'systemctl suspend' \
  #       before-sleep '${pkgs.swaylock}/bin/swaylock -f -c 000000'
  #   '';
  #   wantedBy = ["graphical-session.target"];
  # };
}
