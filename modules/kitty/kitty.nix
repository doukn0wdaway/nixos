{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [kitty];

  home.file = {
    ".config/kitty/kitty.conf" = {
      source = toString ./kitty.conf;
      recursive = true;
    };

    ".config/kitty/tokyo_night_moon.conf" = {
      source = toString ./tokyo_night_moon.conf;
      recursive = true;
    };
  };
}
