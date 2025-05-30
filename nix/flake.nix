{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, here using the nixos-23.11 branch
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Unstable Packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.flake = false;

    # Home Manager
    #home-manager.url = "github:nix-community/home-manager/release-24.11";
    #home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Alacritty theme
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    #home-manager,
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

        #home-manager.nixosModules.home-manager
        {
          #home-manager.useGlobalPkgs = true;
          #home-manager.useUserPackages = true;
          #home-manager.users.chris = import ./home/home.nix;
          #home-manager.extraSpecialArgs = {inherit inputs;};
          #home-manager.backupFileExtension = "backup";

          # Optionally, use home-manager.extraSpecialArgs to pass
          # arguments to home.nix
        }
      ];
    };
  };
}
