{ config, pkgs, ... }:

{
  imports = [
    (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-20.03.tar.gz}/nixos")
  ];

  users = {
    users.nathan = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];

      hashedPassword = "$6$0VnxS1kHgdGFeOjF$ORhZuhctHYfuPqFQ3Qs.L4RkC1Lm3qZJMPJShjqdt4C7zVupthFeU9tUn7qQJBY6TvHRzcRFfu5KfvY/AF3Xd1";

      shell = pkgs.fish;
    };
    mutableUsers = false;
  };

  home-manager = {
    users.nathan = {pkgs, ...}: {
      imports = [
        ./configs/vim.nix
        ./configs/i3.nix
        ./configs/git.nix
      ];

      programs.fish.enable = true;
      programs.bash.enable = true;

      home.file = {
      	".config/alacritty/alacritty.yml".source = ./configs/alacritty.yml;
      };

      home.packages = with pkgs; [
        nodejs
        i3
        dmenu
        firefox
        alacritty
        font-awesome_5
        fira-code 
        compton
        feh
        yarn
        gnumake
        clang
        wget
      ];
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
