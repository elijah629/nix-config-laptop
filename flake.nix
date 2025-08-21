{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Neovim setup
    toucanvim = {
      url = "github:elijah629/touca.nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spotify addons
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    catppuccin,
    home-manager,
    toucanvim,
    spicetify-nix,
    ...
  }: {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      "nixos-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./modules/system/configuration.nix

          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {inherit inputs;};
              users.user = {
                imports = [
                  ./users/user.nix
                  catppuccin.homeModules.catppuccin
                  spicetify-nix.homeManagerModules.default
                ];
              };
            };
          }
        ];
      };
    };
  };
}
