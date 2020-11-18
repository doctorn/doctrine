{ ... }:

{
  home.file.".agda/defaults".text = "standard-library";
  home.file.".agda/libraries".text = "/home/nathan/.agda/standard-library.agda-lib";
  home.file.".agda/standard-library.agda-lib".text = ''
name: standard-library
include: /run/current-system/sw/share/agda/
  '';
}
