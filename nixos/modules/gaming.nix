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
    lutris
    duckstation
    ppsspp
    pcsx2
    extest
    vulkan-tools
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "-H 1440"
      "--borderless"
      "--fullscreen" # Run games in fullscreen mode
      "--fsr" # Enable AMD FidelityFX Super Resolution (FSR)
      "--fsr-sharpness=0.5" # Set FSR sharpness to 0.5
      "--preferred-fps=60" # Limit to 60 frames per second
      "--mangoapp"
    ];
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
    extest.enable = false;
  };

  security.wrappers.gamescope = {
    source = "${pkgs.gamescope}/bin/gamescope";
    capabilities = "cap_sys_nice+ep";
    owner = "root";
    group = "root";
    permissions = "u+s";
  };

  programs.gamemode.enable = true;

  environment.sessionVariables = {
    STEAM_EXTRA_COMPAT_TOOLS_PATH = "/home/chris/.steam/root/compatibilitytools.d";
    MESA_VK_DEVICE_SELECT = "0"; # Use first Mesa GPU
    VK_ICD_FILENAMES = "/etc/vulkan/icd.d/radeon_icd.x86_64.json";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        vulkan-loader
        vulkan-validation-layers
        mesa
      ];
    };

    amdgpu = {
      opencl.enable = true;
      initrd.enable = true;
      amdvlk = {
        enable = true;
        support32Bit.enable = true;
        settings = {
          AllowVkPipelineCachingToDisk = 1;
          ShaderCacheMode = 2; # cache to disk
          EnableVmAlwaysValid = 1;
          IFH = 0; # disable "Infinitely Fast Hardware" (i.e., enable real rendering)
        };
      };
    };
  };
}
