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
    extraGroups = ["networkmanager" "wheel" "seat" "video" "render" "jupyter"];
    packages = with pkgs; [
      fastfetch
      oh-my-posh
      alejandra
      signal-desktop
      localsend
      zed-editor
      unstable.ghostty
    ];
  };
}
