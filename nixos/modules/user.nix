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
    extraGroups = ["networkmanager" "wheel" "seat" "video" "render"];
    packages = with pkgs; [
      neovim
      fastfetch
      oh-my-posh
      alejandra
      _1password-gui
      signal-desktop
      localsend
    ];
  };
}
