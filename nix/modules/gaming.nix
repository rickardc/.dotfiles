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
    extest
    geekbench
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "--fullscreen" # Run games in fullscreen mode
      "--fsr" # Enable AMD FidelityFX Super Resolution (FSR)
      "--fsr-sharpness=0.5" # Set FSR sharpness to 0.5
      "--preferred-fps=60" # Limit to 60 frames per second
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extest.enable = false;
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
