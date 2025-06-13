{
  config,
  pkgs,
  ...
}: {
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.chris = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "chris";
    extraGroups = ["networkmanager" "wheel" "seat" "video" "render" "jupyter" "kfd"];
    packages = with pkgs; [
      fastfetch
      oh-my-posh
      alejandra
      signal-desktop
      librecad
      localsend
      rocmPackages.rocm-smi
      rocmPackages.rocminfo
      sudo-rs
      zed-editor
      unstable.ghostty
    ];
  };
}
