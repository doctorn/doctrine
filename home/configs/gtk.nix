{ pkgs, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.paper-icon-theme;
      name = "Paper";
    };
    theme = {
      package = pkgs.arc-theme;
      name = "Arc-Darker";
    };
  };
}
