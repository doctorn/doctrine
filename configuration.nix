{ config, lib, pkgs, ... }:

{
  imports = [
    <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ./hosts/mithridate.nix
    ./home/configuration.nix
  ];

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

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

  environment.pathsToLink = [ "/share/agda" ];
  environment.systemPackages = [ pkgs.acpi ];

  services.acpid.enable = true;
  services.blueman.enable = true;

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudio.override {
      x11Support = true;
      jackaudioSupport = true;
      airtunesSupport = true;
      bluetoothSupport = true;
      remoteControlSupport = true;
      zeroconfSupport = true;
    };
  };

  networking.networkmanager.enable = true;
}
