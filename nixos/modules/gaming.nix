{
  config,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    duckstation
    extest
    faudio
    libstrangle
    lutris
    mangohud
    ppsspp
    pcsx2
    pciutils
    vulkan-tools
    wine
    winetricks
  ];

  programs.steam = {
    enable = true;
    extest.enable = false;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = false;
    gamescopeSession.args = [
      "-H 1440"
      "--borderless"
      "--fullscreen" # Run games in fullscreen mode
      "--expose-wayland"
      "--hdr-enabled"
      "--mangoapp"
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  programs.gamemode.enable = true;
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  # security.wrappers.gamescope = {
  #   source = "${pkgs.gamescope}/bin/gamescope";
  #   capabilities = "cap_sys_nice+ep";
  #   owner = "root";
  #   group = "root";
  #   permissions = "u+s";
  # };

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/chris/.steam/root/compatibilitytools.d";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        mesa
      ];
      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa
      ];
    };

    # amdgpu = {
    #   opencl.enable = true;
    #   initrd.enable = true;
    #   amdvlk = {
    #     enable = true;
    #     support32Bit.enable = true;
    #     settings = {
    #       AllowVkPipelineCachingToDisk = 1;
    #       ShaderCacheMode = 2; # cache to disk
    #       EnableVmAlwaysValid = 1;
    #       IFH = 0; # disable "Infinitely Fast Hardware" (i.e., enable real rendering)
    #     };
    #   };
    # };
  };
}
