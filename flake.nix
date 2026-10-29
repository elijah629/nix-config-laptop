{
  inputs = {
    # Nixpkgs
    nixpkgs.url = "nixpkgs/nixos-unstable";

    # Catppuccin
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    chatgpt = {
      url = "github:ilysenko/codex-desktop-linux";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:oxcl/nix-flake-helium-browser";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    finamp-flake = {
      url = "github:elijah629/finamp-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      catppuccin,
      home-manager,
      helium,
      ...
    }:
    {
      formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      nixosConfigurations = {
        "nixos-laptop" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./modules/system/configuration.nix

            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            helium.nixosModules.default

            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { inherit inputs; };
                users.user = {
                  imports = [
                    ./users/user.nix
                    catppuccin.homeModules.catppuccin
                  ];
                };
              };
            }
          ];
        };
      };
    };
}
