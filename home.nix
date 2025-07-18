{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  imports = [
    ./modules/kitty/kitty.nix
    ./modules/hyprland/hyprland.nix
    ./modules/waybar/waybar.nix
    ./modules/tmux/tmux.nix
  ];
  home.username = "etraxis";
  home.homeDirectory = "/home/etraxis";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.
  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.syncthing
  ];

  programs.zsh = {
    enable = true;
    # Если хотите добавить алиасы для zsh
    shellAliases = {
      vpn-up = "wg-quick up ~/nixos/secrets/vpn.conf";
      vpn-down = "wg-quick down ~/nixos/secrets/vpn.conf";
      update = "sudo nixos-rebuild switch --flake ~/nixos#default";
      updateImp = "sudo nixos-rebuild switch --flake ~/nixos#default --impure";
    };
    # Включаем Oh My Zsh
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "docker"
      ];
      theme = "agnoster";
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage

  # plain files is through 'home.file'.
  # # Building this configuration will create a copy of 'dotfiles/screenrc' in
  # # the Nix store. Activating the configuration will then make '~/.screenrc' a
  # # symlink to the Nix store copy.
  # ".screenrc".source = dotfiles/screenrc;

  # # You can also set the file content immediately.
  # ".gradle/gradle.properties".text = ''
  #   org.gradle.console=verbose
  #   org.gradle.daemon.idletimeout=3600000
  # '';

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #
  home.sessionVariables = {
  };

  # Enable Syncthing service in Home Manager
  services.syncthing = {
    enable = true;
    settings = {
      devices = {
        "pixel-phone" = {id = "FAXZU23-LUJRCHV-CQUXW22-KFFYIYS-7L3UD4H-DABN22A-MCXQ7Z7-MMMHDQO";};
        "windows-pc" = {id = "2RZBJYP-WZEO2XX-YHSMKOO-XH5EMR6-3LQRYJJ-V3RE3AF-VIG4KNU-EQQVVQ3";};
      };
      gui = {
        user = ""; # Replace with your desired user
        password = ""; # Set your desired password (plaintext or password hash)
      };
      folders = {
        "sync" = {
          path = "/home/etraxis/sync";
        };
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
