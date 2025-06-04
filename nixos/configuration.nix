# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/gaming.nix
    ./modules/fonts.nix
    ./modules/firefox.nix
    ./modules/flatpak.nix
    ./modules/gnome.nix
    ./modules/homelab.nix
    #./modules/jupyter.nix
    ./modules/python.nix
    ./modules/shells.nix
    ./modules/systemPackages.nix
    ./modules/sway.nix
    ./modules/program_options.nix
    ./modules/user.nix
    ./modules/vscode.nix
  ];

  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      backgroundColor = "#24283b";
      efiSupport = true;
      gfxmodeEfi = "1024x768";
      device = "nodev";
      configurationLimit = 20;
    };
  };

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.initrd.luks.devices."luks-62039fe4-6f6d-4338-a623-2b9fe1cb704e".device = "/dev/disk/by-uuid/62039fe4-6f6d-4338-a623-2b9fe1cb704e";
  networking = {
    hostName = "nixos"; # Define your hostname.
    # Enable networking
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Open ports in the firewall.
    firewall = {
      enable = true;
      allowedTCPPorts = [22 53317 8080 8888]; # 53317 for localSend
      allowedUDPPorts = [53317 8888];
    };
  };

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  nix = {
    settings = {
      experimental-features = ["nix-command" "flakes"];
      warn-dirty = false;
      auto-optimise-store = true;
    };
    optimise = {
      automatic = true;
      dates = ["quarterly"];
      randomizedDelaySec = "20min";
    };
    gc = {
      automatic = true;
      dates = "quarterly";
      randomizedDelaySec = "20min";
      options = "--delete-older-than 90d";
    };
  };

  # Check when this runs next
  # systemctl list-timers '*nix-*' '*upgrade*' --all
  system.autoUpgrade = {
    enable = true;
    flake = ".#nixos"; # Match nixosConfigurations.<your-hostname> in flake.nix
    dates = "weekly";
    randomizedDelaySec = "20min";
    allowReboot = false;
  };

  # default apps
  # xdg.mime = {
  #   enable = true;
  #   defaultApplications = {
  #     "application/pdf" = "org.gnome.Evince.desktop";
  #     "text/plain" = "org.gnome.TextEditor.desktop";
  #     "x-scheme-handler/http" = "firefox.desktop";
  #     "x-scheme-handler/https" = "firefox.desktop";
  #   };
  # };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = [22];
    settings = {
      PasswordAuthentication = true;
      AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "prohibit-password"; # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
