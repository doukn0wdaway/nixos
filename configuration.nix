{
  config,
  lib,
  hostname,
  pkgs,
  inputs,
  ...
}: {
  imports =
    [
      ./modules/bspwm
    ]
    ++ lib.optional (hostname == "pc") ./pc-hardware-configuration.nix
    ++ lib.optional (hostname == "laptop") ./laptop-hardware-configuration.nix;

  networking.hostName = hostname;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 2;
  boot.kernelParams = [
    "amdgpu.gpu_recovery=1"
    "amd_iommu=off"
    "amdgpu.mcbp=0"
  ];

  networking.networkmanager.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };
  nix.settings = {
    auto-optimise-store = true;
    min-free = "30G";
    max-free = "150G";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  # Set your time zone.
  time.timeZone = "Europe/Kyiv";
  nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  fonts.packages =
    builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);

  fonts.fontconfig.enable = true;

  services.xserver = {
    enable = true;
    xkb.layout = "us,ru";
    xkb.options = "grp:alt_shift_toggle";
    displayManager.gdm.enable = true;
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  hardware.bluetooth.enable = true;

  programs.hyprland.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    jack.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;

    wireplumber.extraConfig."10-bluez" = {
      "monitor.bluez.properties" = {
        "bluez5.enable-sbc-xq" = true;
        "bluez5.enable-msbc" = true;
        "bluez5.enable-hw-volume" = true;
        "bluez5.roles" = [
          "hsp_hs"
          "hsp_ag"
          "hfp_hf"
          "hfp_ag"
        ];
      };
    };
  };

  services.openssh.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  programs.zsh.enable = true;
  programs.firefox.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users.users.etraxis = {
    isNormalUser = true;
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
    openssh.authorizedKeys.keyFiles = ["/home/etraxis/.ssh/id_ed25519.pub"];
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs hostname;};
    backupFileExtension = "backup";
    users = {
      etraxis = import ./home.nix;
    };
  };

  security.sudo.wheelNeedsPassword = false;

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (lib.getName pkg) [
  #     "obsidian"
  #     "discord"
  #     "opera"
  #   ];

  programs.thunar.enable = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
    pkgs.xdg-desktop-portal-gtk
  ];

  environment.systemPackages = with pkgs; [
    hoppscotch
    bruno
    wget
    btop
    networkmanager
    wireguard-tools
    git
    sxhkd
    dunst
    rofi-wayland
    libnotify
    telegram-desktop
    keepassxc
    ranger
    wl-clipboard
    obs-studio
    lazygit
    unzip
    pavucontrol
    obsidian
    discord
    qbittorrent
    vlc
    bluetuith
    kicad
    orca-slicer
    brightnessctl
    freecad-wayland
    libayatana-appindicator
    reaper
    reaper-reapack-extension
  ];

  systemd.tmpfiles.rules = [
    "d /mnt 0777 root root -"
    "d /mnt/smb 0777 root root -"
  ];

  fileSystems."/mnt/smb" = {
    device = "//10.0.0.4/public"; # адрес твоего Samba-сервера/шары
    fsType = "cifs";
    options = [
      "guest" # гостевой доступ, без логина/пароля
      "vers=3.11" # версия SMB (можно 3.0, если нужно)
      "rw"
      "iocharset=utf8"
      "x-systemd.automount" # ленивый автомаунт при первом обращении
      "noauto" # не пытаться монтировать на буте до запроса
      # Если хочется «не думать» про права:
      # "file_mode=0777"
      # "dir_mode=0777"
    ];
  };

  environment.sessionVariables = {
    WLR_RENDERER = "vulkan"; # сначала Vulkan (на AMD обычно ок)
    NIXOS_OZONE_WWL = "1";
    # Если вдруг будут глюки — поменять на:
    # WLR_RENDERER = "gles2";
    # На некоторых GPU помогает отключить liftoff:
    # WLR_USE_LIBLIFTOFF = "0";
  };

  system.stateVersion = "24.11";
}
