{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ kitty ];

   home.file = {
    ".config/kitty/kitty.conf" = {
      source = toString ./dotfiles/kitty/kitty.conf;
      recursive = true;
    };

    ".config/kitty/tokyo_night_moon.conf" = {
      source = toString ./dotfiles/kitty/tokyo_night_moon.conf;
      recursive = true;
    };
  };
}
