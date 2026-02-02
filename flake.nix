{
  description = "Colbary07 NixOS/NixOS-WSL Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    flake-parts.url = "github:hercules-ci/flake-parts";
    lazyvim.url = "github:pfassina/lazyvim-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      lazyvim,
      ...
    }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake = {
        nixosConfigurations = {
          # My Computer
          nixos = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/nixos/default.nix
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = { 
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecoalArgs = { inherit inputs; };
                  users.colbary = import ./modules/home/default.nix;
                };
              }
            ];
            specialArgs = { inherit inputs; };
          };
          # Windows For WSL
          nixos-wsl = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./hosts/nixos-wsl/default.nix
              inputs.nixos-wsl.nixosModules.wsl
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager = {
                  useGlobalPkgs = true;
                  useUserPackages = true;
                  extraSpecialArgs = { inherit inputs; };
                  users.colbary = import ./modules/home/default.nix;
                };
              }
            ];
            specialArgs = { inherit inputs; };
          };
        };
      };
    };
}
