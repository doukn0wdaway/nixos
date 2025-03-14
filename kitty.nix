{ pkgs, ... }:

{
  # Устанавливаем kitty в systemPackages
  environment.systemPackages = with pkgs; [ kitty ];

  # Конфигурируем kitty
  # home.file.".config/kitty/kitty.conf".source="./kitty.conf";
  home.file.".config/kitty/tokyo_night_moon.conf".source="./dotfiles/kitty/tokyo_night_moon.conf";
}
