{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.faba-icon-theme;
      name = "Faba";
    };
    theme = {
      package = pkgs.ant-bloody-theme;
      name = "Ant";
    };
  };
}
