{ config, lib, ... }:

{
  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    nix-direnv = {
      enable = true;
      enableFlakes = true;
    };
  };
}
