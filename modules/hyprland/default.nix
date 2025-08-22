{
  config,
  hostname,
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [hyprland hyprshot];
  home.file = {
    ".config/hypr/hyprland.conf" = {
      source =
        if hostname == "pc"
        then ./pc-hyprland.conf
        else ./laptop-hyprland.conf;
      recursive = true;
    };
  };
}
