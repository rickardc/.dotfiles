# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./modules/gaming.nix
    ./modules/gnome.nix
    ./modules/languages.nix
    ./modules/vscode.nix
    ./modules/ollama.nix
    ./modules/jupyter.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-697220af-dbc8-448a-9bf9-b28e66d56961".device = "/dev/disk/by-uuid/697220af-dbc8-448a-9bf9-b28e66d56961";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable flakes
  nix = {
    settings.experimental-features = ["nix-command" "flakes"];
    settings.warn-dirty = false;
    settings.auto-optimise-store = true;
  };

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # ip link show - to find interface name
  networking.networkmanager.enable = true;
  networking.interfaces.wlp9s0.wakeOnLan.enable = true;

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

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

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  environment.sessionVariables = rec {
    GSK_RENDERER = "gl";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "au";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    #alsa.enable = true;
    #alsa.support32Bit = true;
    pulse.enable = true;
    #audio.enable = true;
    #wireplumber.enable = true;
    # If you want to use JACK applications, uncomment this
    # jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    # media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true; # enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
  hardware.bluetooth.settings = {
    General = {
      ControllerMode = "bredr";
      Disable = "Socket,Headset";
      Enable = "Media,Source,Sink,Gateway";
      AutoConnect = true;
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "chris";
    extraGroups = ["networkmanager" "wheel" "docker" "libvirt" "kvm" "jupyter"];
    packages = with pkgs; [
      # cli
      bat
      bat-extras.batman
      neovim
      ripgrep
      os-prober
      man
      unzip
      fastfetch
      btop
      nvtopPackages.amd # nvtop
      nixd
      nil
      alejandra
      bluez
      pulseaudio
      pavucontrol
      #python312Packages.ds4drv

      # gui
      upscayl
      parabolic
      mission-center
      vlc
      localsend
      darktable
      pika-backup
      additions.ida-free
      signal-desktop
      _1password-gui
      zed-editor
      discord
      unstable.ghostty
    ];
  };

  # Enable zsh
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable flatpak
  services.flatpak.enable = true;

  systemd.services.flatpak-repo = {
    wantedBy = ["multi-user.target"];
    path = [pkgs.flatpak];
    script = ''
      flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    '';
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #  cli
    wget
    git
    curl
    gh
    fd
    tmux
    glib
    tree
    tree-sitter
    stow

    sway
    wofi
    waybar
  ];

  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "FiraCode"
        "DroidSansMono"
        "Meslo"
      ];
    })
    openmoji-color
  ];

  qt = {
    enable = true;
    style = "adwaita-dark";
    platformTheme = "gnome";
  };

  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    rootless.setSocketVariable = true;
  };

  virtualisation.libvirtd.enable = true;

  #hardware.graphics.enable = true;
  #hardware.graphics.enable32Bit = true;

  services.xserver.videoDrivers = ["amdgpu"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

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

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [22 53317 8080 8888]; # 53317 for localSend
  networking.firewall.allowedUDPPorts = [53317 8888];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  #

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
