{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprswitch.url = "github:h3rmt/hyprswitch/release";
  };


outputs = { self, nixpkgs, home-manager, ... }@inputs: 
let
  system = "x86_64-linux";  # Define the system architecture here
in
{
  nixosConfigurations.default = nixpkgs.lib.nixosSystem {
    system = system;
    specialArgs = {
      inherit self;
      inherit inputs;
    };
    modules = [
      ./configuration.nix  # Your NixOS configuration
      home-manager.nixosModules.default  # Home Manager module
    ];
  };
};
}
