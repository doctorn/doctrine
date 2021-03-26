{ system, config, inputs, lib, name, pkgs, ... }:

{
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;

  i18n.defaultLocale = "en_GB.UTF-8";
  console = {
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "uk";
  };

  time.timeZone = "Europe/London";

  systemd.packages = [
    pkgs.networkmanager
  ];

  environment.systemPackages = with pkgs; [
    acpi
    strongswan
  ];

  services.acpid.enable = true;
  services.blueman.enable = true;

  networking = {
    hostName = name;
    networkmanager.enable = true;
    networkmanager.enableStrongSwan = true;
  };
}
