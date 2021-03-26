{ config, inputs, lib, name, pkgs, ... }:

with lib;
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  
  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    users.nathan = {
      imports = [
        (import ../../home/profile.nix)
        (import ../../home/config)
      ];

      home.file.".nixpkgs".source = inputs.nixpkgs;
      systemd.user.sessionVariables."NIX_PATH" =
        mkForce "nixpkgs=$HOME/.nixpkgs\${NIX_PATH:+:}$NIX_PATH";
    };
  };

  users = {
    users.nathan = {
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" ];

      hashedPassword = "$6$0VnxS1kHgdGFeOjF$ORhZuhctHYfuPqFQ3Qs.L4RkC1Lm3qZJMPJShjqdt4C7zVupthFeU9tUn7qQJBY6TvHRzcRFfu5KfvY/AF3Xd1";

      shell = pkgs.fish;
    };

    mutableUsers = false;
  };
}
