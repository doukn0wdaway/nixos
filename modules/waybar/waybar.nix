{ config, pkgs, ... }:
{
  home.packages = with pkgs; [ waybar ];
   home.file = {
    ".config/waybar/config" = {
      source = toString ./config;
      recursive = true;
    };
  };
}
