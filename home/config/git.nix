{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    userEmail = "me@nathancorbyn.com";
    userName = "Nathan Corbyn";
    extraConfig = {
      credential.helper = "store";
      core.askPass = "";
    };
  };
}
