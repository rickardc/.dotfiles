{
  config,
  pkgs,
  ...
}: {
  fonts.packages = with pkgs; [
    dejavu_fonts
    noto-fonts
    noto-fonts-emoji
    font-awesome
    openmoji-color

    # https://mynixos.com/nixpkgs/packages/nerd-fonts
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    nerd-fonts.meslo-lg
    nerd-fonts.blex-mono
    nerd-fonts.gohufont
    nerd-fonts.go-mono
    nerd-fonts.terminess-ttf
    nerd-fonts.iosevka
  ];
}
