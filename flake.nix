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

    hyprswitch.url = "github:h3rmt/hyprswitch/release";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nvf,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    mkHost = hostPath:
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit self inputs;
        };
        modules = [
          ./configuration.nix
          ./home.nix
          home-manager.nixosModules.home-manager
          nvf.nixosModules.default
          hostPath
        ];
      };
  in {
    nixosConfigurations = {
      laptop = mkHost ./laptop/configuration.nix;
      pc = mkHost ./pc/configuration.nix;
    };

    homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
      system = system;
    };
  };
}
