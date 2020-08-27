{ config, pkgs, ... }:

{
  imports = [
    (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
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

  programs.fish.enable = true;

  home-manager = {
    users.nathan = {pkgs, ...}: {
      programs.bash.enable = true;

      home.file = {
      	".config/alacritty/alacritty.yml".source = ./configs/alacritty.yml;
      	".vimrc".source = ./configs/config.vim;
      };

      home.packages = with pkgs; [
        git
        nodejs
        i3
        dmenu
        firefox
        alacritty
        font-awesome_5
        fira-code 
        vim
        compton
        feh
      ];

      xsession.enable = true;
      xsession.scriptPath = ".hm-xsession";
      xsession.windowManager.i3 = {
        enable = true;
        config = let
          modifier = "Mod4";
          workspaces = {
            one = "1";
            two = "2";
            three = "3";
            four = "4";
            five = "5";
            six = "6";
            seven = "7";
            eight = "8";
            nine = "9";
            ten = "10";
          };
        in
        {
          bars = [
            {
              position = "top";
            }
          ];

          keybindings = {
            "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
            "${modifier}+d" = "exec --no-startup-id dmenu_run";

            "${modifier}+1" = "workspace ${workspaces.one}";
            "${modifier}+2" = "workspace ${workspaces.two}";
            "${modifier}+3" = "workspace ${workspaces.three}";
            "${modifier}+4" = "workspace ${workspaces.four}";
            "${modifier}+5" = "workspace ${workspaces.five}";
            "${modifier}+6" = "workspace ${workspaces.six}";
            "${modifier}+7" = "workspace ${workspaces.seven}";
            "${modifier}+8" = "workspace ${workspaces.eight}";
            "${modifier}+9" = "workspace ${workspaces.nine}";
            "${modifier}+0" = "workspace ${workspaces.ten}";

            "${modifier}+Shift+1" = "move container to workspace ${workspaces.one}";
            "${modifier}+Shift+2" = "move container to workspace ${workspaces.two}";
            "${modifier}+Shift+3" = "move container to workspace ${workspaces.three}";
            "${modifier}+Shift+4" = "move container to workspace ${workspaces.four}";
            "${modifier}+Shift+5" = "move container to workspace ${workspaces.five}";
            "${modifier}+Shift+6" = "move container to workspace ${workspaces.six}";
            "${modifier}+Shift+7" = "move container to workspace ${workspaces.seven}";
            "${modifier}+Shift+8" = "move container to workspace ${workspaces.eight}";
            "${modifier}+Shift+9" = "move container to workspace ${workspaces.nine}";
            "${modifier}+Shift+0" = "move container to workspace ${workspaces.ten}";

            "${modifier}+Left" = "focus left";
            "${modifier}+Down" = "focus down";
            "${modifier}+Up" = "focus up";
            "${modifier}+Right" = "focus right";

            "${modifier}+Shift+Left" = "move left";
            "${modifier}+Shift+Down" = "move down";
            "${modifier}+Shift+Up" = "move up";
            "${modifier}+Shift+Right" = "move right";

            "${modifier}+r" = "mode resize";

            "${modifier}+o" = "layout toggle split";
            "${modifier}+i" = "layout tabbed";
            "${modifier}+u" = "layout stacking";
            "${modifier}+f" = "fullscreen toggle";
            "${modifier}+Shift+space" = "floating toggle";
            "${modifier}+n" = "split v";
            "${modifier}+m" = "split h";

            "${modifier}+Shift+c" = "reload";
            "${modifier}+Shift+e" =
              "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";
            "${modifier}+Shift+q" = "kill";
            "${modifier}+Shift+r" = "restart";
          };
        };

        extraConfig = ''
          exec --no-startup-id ${pkgs.compton}/bin/compton -b -f
          exec_always feh --bg-fill ${./configs/alone.jpg}
        '';
      };
    };

    useUserPackages = true;
    useGlobalPkgs = true;
  };
}
