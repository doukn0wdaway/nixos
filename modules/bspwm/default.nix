{ ... }: {
  services.xserver.windowManager.bspwm = {
    enable = true;
    configFile = toString ./bspwmrc;
    sxhkd.configFile = toString ./sxhkdrc;
  };
}
