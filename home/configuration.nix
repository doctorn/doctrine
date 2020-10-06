{ config, lib, pkgs, ... }:

with lib;
let
  cfg = config.doctrine;
in
{
  imports = [
    (import "${builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-20.03.tar.gz}/nixos")
  ];

  options.doctrine.colors =
    let
      mkColour = description: default: mkOption {
        inherit default;
        description = "Define the colour for ${description}.";
        example = "ffffff";
        type = types.str;
      };
    in
    {
      black = mkColour "black" "6d7381";
      red = mkColour "red" "d84231";
      green = mkColour "green" "78c42d";
      yellow = mkColour "yellow" "fcba04";
      blue = mkColour "blue" "1da1f2";
      magenta = mkColour "magenta" "f94a76";
      cyan = mkColour "cyan" "30d1f2";
      orange = mkColour "orange" "fe8019";

      brightBlack = mkColour "bright black" "777e8d";
      brightRed = mkColour "bright red" "db5343";
      brightGreen = mkColour "bright green" "84c940";
      brightYellow = mkColour "bright yellow" "fcc01a";
      brightBlue = mkColour "bright blue" "f95882";
      brightMagenta = mkColour "bright magenta" "f95882";
      brightCyan = mkColour "bright cyan" "42d5f3";
      brightOrange = mkColour "bright orange" "fe8b2d";
      
      zero = mkColour "darkest dark" "32353c";
      dark0 = mkColour "darkest black" "373a41";
      dark1 = mkColour "darker black" "41454d";
      dark2 = mkColour "black" "4c515a";
      dark3 = mkColour "darker grey" "575c67";
      dark4 = mkColour "grey" "626874";

      light0 = mkColour "brightest white" "f2f3f4";
      light1 = mkColour "brighter white" "d9dbdf";
      light2 = mkColour "white" "c1c4cb";
      light3 = mkColour "lightest grey" "a8acb6";
      light4 = mkColour "lighter grey" "8f9fa1";
    };

  config = {
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
          ./configs/fish.nix
          ./configs/git.nix
          (import ./configs/i3.nix config.doctrine)
        ];

        programs.bash.enable = true;

        home = {
          file = {
            ".config/alacritty/alacritty.yml".source = ./configs/alacritty.yml;
          };

          keyboard.layout = "gb";
          language.base = "en_GB.utf8";

          packages = with pkgs; [
            nodejs
            i3
            i3blocks
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
      };

      useUserPackages = true;
      useGlobalPkgs = true;
    };
  };
}
