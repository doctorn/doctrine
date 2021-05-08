{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.faba-icon-theme;
      name = "Yaru";
    };
    theme = {
      package = pkgs.yaru-theme;
      name = "Yaru";
    };
  };
}
