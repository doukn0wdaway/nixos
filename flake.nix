{
  description = "NixOS config with Home Manager and Hyprswitch";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    mkHost = hostname:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit hostname inputs;};
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          nvf.nixosModules.default
        ];
      };
  in {
    nixosConfigurations = {
      pc = mkHost "pc";
      laptop = mkHost "laptop";
    };
  };
}
