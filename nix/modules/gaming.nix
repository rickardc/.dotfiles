{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    vulkan-loader
    wine
    winetricks
    libstrangle
    faudio
    mangohud
    protonup
    lutris
    duckstation
    pcsx2
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extest.enable = true;
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/chris/.steam/root/compatibilitytools.d";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
      };
    };
  };
}
