{ config, pkgs, ... }:

let
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
in {
  xsession.enable = true;
  xsession.scriptPath = ".hm-xsession";
  xsession.pointerCursor = {
    package = pkgs.gnome3.adwaita-icon-theme;
    name = "Adwaita";
  }; 
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      bars = [];

      colors = with config.doctrine.colors; {
        focused = {
          background = "#${zero}";
          border = "#${zero}";
          childBorder = "#${zero}";
          indicator = "#${cyan}";
          text = "#${light1}";
        };
        focusedInactive = {
          background = "#${dark0}";
          border = "#${dark0}";
          childBorder = "#${dark0}";
          indicator = "#${cyan}";
          text = "#${black}";
        };
        unfocused = {
          background = "#${dark0}";
          border = "#${dark0}";
          childBorder = "#${dark0}";
          indicator = "#${cyan}";
          text = "#${black}";
        };
        urgent = {
          background = "#${dark0}";
          border = "#${orange}";
          childBorder = "#${orange}";
          indicator = "#${cyan}";
          text = "#${orange}";
        };
      };

      fonts = [ "Fira Code 10" ];

      keybindings = with config.doctrine.colors; {
        "${modifier}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${modifier}+d" = "exec ${pkgs.rofi}/bin/rofi -show drun";
        "${modifier}+Tab" = "exec ${pkgs.rofi}/bin/rofi -show window";

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

    extraConfig = let
      defaultWorkspace = "workspace ${workspaces.one}";
    in ''
      new_window normal 0px

      ${defaultWorkspace} output primary

      exec --no-startup-id ${pkgs.networkmanagerapplet}/bin/nm-applet
      exec --no-startup-id ${pkgs.blueman}/bin/blueman-applet
      exec --no-startup-id ${pkgs.dropbox}/bin/dropbox
      exec --no-startup-id ${pkgs.compton}/bin/compton -b -f
      exec_always feh --bg-fill ${./bg.jpg}

      exec_always ${pkgs.systemd}/bin/systemctl --user restart polybar
    '';
  };
}
