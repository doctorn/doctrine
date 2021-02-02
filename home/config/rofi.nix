{ config, lib, pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    font = "FiraCode 11";
    terminal = "${pkgs.alacritty}/bin/alacritty";
    theme = "Arc-Dark";
  };
}
