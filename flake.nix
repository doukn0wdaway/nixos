
{
  description = "NixOS config with Home Manager and Hyprswitch";

  inputs = {
    # Nixpkgs for package management
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Hyprswitch input
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";  # Define your target system architecture
      pkgs = import nixpkgs {
        inherit system;
      };
    in
    {
      # NixOS configuration
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit self;
          inherit inputs;
        };
        modules = [
          ./configuration.nix  # Your main NixOS configuration file
          home-manager.nixosModules.home-manager  # Home Manager module for user configuration
        ];
      };

      # Home Manager configuration for the user
      homeConfigurations.default = home-manager.lib.homeManagerConfiguration {
        system = system;
        modules = [ ./kitty.nix ]; 
      };
    };
}

