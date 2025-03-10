{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux"; # Устанавливаем архитектуру системы
    in
    {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        system = system;
        specialArgs = {
          inherit self;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.default # Подключаем модуль Home Manager
        ];
      };
    };
}
