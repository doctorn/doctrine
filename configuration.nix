{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./hosts/melvin.nix
    ./home/configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "uk";
  };

  time.timeZone = "Europe/London";

  systemd.packages = [
    pkgs.networkmanager
  ];

  networking.networkmanager.enable = true;

  services.xserver = {
    enable = true;
    layout = "gb";
    displayManager.lightdm.enable = true;
    displayManager.defaultSession = "home-manager";
    displayManager.session = [
      {
        name = "home-manager";
        manage = "desktop";
        start = ''
          ${pkgs.runtimeShell} $HOME/.hm-xsession
          waitPID=$!
        '';
      }
    ];
  };
}
