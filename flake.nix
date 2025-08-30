{
  description = "NixOS config with Home Manager, NVF, and Opera backport/override";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:notashelf/nvf";
    };

    nixpkgs-23_11.url = "github:NixOS/nixpkgs/nixos-23.11";

    # vim = {
    #   url = "github:doukn0wdaway/vim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  outputs = {
    self,
    nixpkgs,
    nixpkgs-23_11,
    home-manager,
    # vim,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    nixOld = {
      "23_11" = import nixpkgs-23_11 {
        inherit system;
        config.allowUnfree = true;
      };
      # "24_05" = import nixpkgs-24_05 { inherit system; config.allowUnfree = true; };
    };

    mkHost = hostname: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
      nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit hostname inputs;
          custom_pkgs = import ./packages {inherit pkgs nixOld;};
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager

          ({custom_pkgs, ...}: {
            environment.systemPackages = [
              custom_pkgs.opera
              custom_pkgs.freecad-wrapped
              # vim.packages.${system}.default
            ];
          })
        ];
      };
  in {
    nixosConfigurations = {
      pc = mkHost "pc";
      laptop = mkHost "laptop";
    };

    packages.${system} = import ./packages {
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      inherit nixOld;
    };

    apps.${system}.default = {
      type = "app";
      program = "${self.packages.${system}.opera}/bin/opera";
    };
  };
}
