{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Neovim setup
    nixvim.url = "github:dc-tec/nixvim";

    # NUR for firefox addons
    nur.url = "github:nix-community/NUR";

    # Spotify addons
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Catppuccin
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs =
    inputs@{
      nixpkgs,
      home-manager,
      nixvim,
      nur,
      spicetify-nix,
      catppuccin,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.nixfmt-rfc-style;
      nixosConfigurations."nixos-laptop" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/system/configuration.nix
          { nixpkgs.overlays = [ nur.overlays.default ]; }
          home-manager.nixosModules.home-manager
          catppuccin.nixosModules.catppuccin
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.user = {
              imports = [
                (import ./users/user.nix inputs)
                catppuccin.homeManagerModules.catppuccin
                spicetify-nix.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
}
