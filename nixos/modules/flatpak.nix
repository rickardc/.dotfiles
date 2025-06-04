{
  config,
  lib,
  pkgs,
  ...
}: {
  # Enable flatpak
  services.flatpak.enable = true;

  # Add flathub repo
  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };
}
