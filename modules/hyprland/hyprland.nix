{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [hyprland hyprshot];
  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = toString ./hyprland.conf;
      recursive = true;
    };
  };
}
