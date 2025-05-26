{
  description = "A very basic flake";

  inputs = {
    # NixOS official package source, here using the nixos-23.11 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";

    # Unstable Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.flake = false;

    # Alacritty theme
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    alacritty-theme,
    ...
  } @ inputs: {
    # The host with the hostname `my-nixos` will use this configuration
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {inherit inputs;};

      modules = [
        ./configuration.nix
        # Overlay nixpkgs-unstable packages into the stable channel
        {
          nixpkgs.overlays = [
            (final: prev: {
              unstable = import nixpkgs-unstable {
                system = "x86_64-linux";
                config.allowUnfree = true;
              };

              # add my packages
              additions = import ./pkgs final.pkgs;
            })

            # Expose alacritty-theme from inputs
            alacritty-theme.overlays.default
          ];
        }
      ];
    };
  };
}
