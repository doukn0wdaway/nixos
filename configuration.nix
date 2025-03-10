
{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "doukn0wdaway-laptop"; 
 networking.networkmanager.enable = true;  
 nix.settings.experimental-features = [ "nix-command" "flakes"];

  # Set your time zone.
 time.timeZone = "Europe/Kyiv";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

services.xserver = {
  enable = true;
  xkb.layout = "us,ru";  
  xkb.options = "grp:alt_shift_toggle";  
};


  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
security.rtkit.enable = true;
services.pipewire = {
  enable = true;
  pulse.enable = true;
  jack.enable = true;
  alsa.enable = true;
  alsa.support32Bit = true;
};

  # Enable touchpad support (enabled default in most desktopManager).
services.libinput.enable = true;

programs.zsh.enable = true;
programs.firefox.enable = true;
users.defaultUserShell = pkgs.zsh;
users.users.etraxis = {
	isNormalUser = true;
	extraGroups = [ "wheel" "networkmanager" ];
	shell = pkgs.zsh;
};

home-manager = {
	extraSpecialArgs = { inherit inputs; };
	backupFileExtension = "backup";
	users = {
		"etraxis" = import ./home.nix;
	};
};

programs.hyprland.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "vivaldi"  
  ];



xdg.portal.enable = true;

environment.systemPackages = with pkgs; [
  wget
  btop
  networkmanager
  git
  waybar
  dunst
  rofi-wayland
  libnotify
  vivaldi
  telegram-desktop
  keepassxc
  ranger
  wl-clipboard
];

  system.stateVersion = "24.11"; 
}

