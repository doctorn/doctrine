{ config, inputs, lib, name, pkgs, ... }:

{
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  services = {
    gnome.gnome-keyring.enable = true;

    xserver = {
      enable = true;
      layout = "gb";

      libinput.enable = true;

      displayManager = {
        lightdm.enable = true;

        autoLogin.enable = true;
        autoLogin.user = config.users.users.nathan.name;

        defaultSession = "home-manager";
        session = [
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
    };
  };
}
