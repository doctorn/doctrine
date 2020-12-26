doctrine:
{ config, lib, pkgs, ... }:

with lib;
let
  barName = "doctrine";

  mkBarScript = module: contents:
    let
      name = "doctrine-polybar-${module}";
      dir = pkgs.writeScriptBin name (
        with pkgs; ''
          #! ${runtimeShell} -e
          ${contents}
        ''
      );
    in
    "${dir}/bin/${name}";
in
{
  services.polybar = {
    config = {
      "bar/${barName}" = with doctrine.colors; {
        "bottom" = false;
        "background" = "#${zero}";
        "font-0" = "Fira Code:size=10";
        "font-1" = "FontAwesome5Free:style=Solid:size=9;0";
        "font-2" = "FontAwesome5Brands:style=Solid:size=9;0";
        "height" = "25";
        "locale" = config.home.language.base;
        "module-margin" = "1";
        "padding" = "1";
        "modules-right" = [ "battery" "date" ];
        "modules-center" = [ "time" ];
        "modules-left" = [ "i3" "spotify" "volume" ];
        "monitor" = "\${env:MONITOR:}";
        "border-top-size" = "0";
        "border-bottom-size" = "0";
        "border-right-size" = "0";
        "border-left-size" = "0";
        "border-color" = "#${zero}";
        "tray-position" = "right";
        "tray-offset-y" = "0";
        "tray-offset-x" = "0";
        "tray-padding" = "10";
        "tray-transparent" = false;
        "tray-background" = "#${doctrine.colors.zero}";
        "tray-detached" = false;
      };
      "module/date" = {
        type = "custom/script";
        interval = "3.0";
        format-foreground = "#${doctrine.colors.black}";
        exec = mkBarScript "date" (
          with pkgs; ''
            echo " $(${coreutils}/bin/date +"%d/%m/%Y")"
          ''
        );
      };
      "module/time" = {
        type = "custom/script";
        interval = "1.0";
        format-foreground = "#${doctrine.colors.black}";
        exec = mkBarScript "time" (
          ''
            echo " $(${pkgs.coreutils}/bin/date +%H:%M:%S)"
          ''
        );
      };
      "module/i3" = with doctrine.colors; {
        "type" = "internal/i3";
        "enable-click" = false;
        "enable-scroll" = false;
        "index-sort" = true;
        "label-focused-foreground" = "#${light1}";
        "label-unfocused-foreground" = "#${black}";
        "label-visible-foreground" = "#${black}";
        "label-urgent-foreground" = "#${orange}";
      };
      "module/volume" = {
        type = "custom/script";
        interval = "0.01";
        format-foreground = "#${doctrine.colors.black}";
        exec = mkBarScript "volume-status" (
          with pkgs; ''
            if [[ $(${alsaUtils}/bin/amixer get Master | \
                    ${gnugrep}/bin/grep 'Right' | \
                    ${gawk}/bin/awk -F'[][] ' '{ print $2 }' | \
                    ${coreutils}/bin/tr -d '\n') = "[on]" ]]; then
              volume=$(${alsaUtils}/bin/amixer get Master | \
                       ${gnugrep}/bin/grep 'Right' | \
                       ${gawk}/bin/awk -F'[][]' '{ print $2 }' | \
                       ${coreutils}/bin/tr -d '\n')
              echo -ne " $volume"
            else
              echo -ne " off"
            fi
          ''
        );
        click-left = mkBarScript "volume-toggle" (
          with pkgs; ''
            ${alsaUtils}/bin/amixer sset Master toggle
          ''
        );
        scroll-up = mkBarScript "volume-up" (
          with pkgs; ''
            ${alsaUtils}/bin/amixer sset Master 2%+
          ''
        );
        scroll-down = mkBarScript "volume-down" (
          with pkgs; ''
            ${alsaUtils}/bin/amixer sset Master 2%-
          ''
        );
      };
      "module/battery" = {
        type = "custom/script";
        interval = "1.0";
        format-foreground = "#${doctrine.colors.black}";
        exec = mkBarScript "battery" (
          ''
            echo " battery"
          ''
        );
      };
      "module/spotify" = {
        type = "custom/script";
        interval = "1";
        format-foreground = "#${doctrine.colors.magenta}";
        exec = mkBarScript "spotify-status" (
          with pkgs; ''
            STRING="$(${dbus}/bin/dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify \
                      /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get \
                      string:'org.mpris.MediaPlayer2.Player' string:'Metadata' \
                      2>/dev/null | ${gawk}/bin/awk '/artist/{getline; getline; print}' | \
                      ${coreutils}/bin/cut -d'"' -f2) - $(${dbus}/bin/dbus-send --print-reply --session \
                      --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 \
                      org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' \
                      string:'Metadata' 2>/dev/null | ${gawk}/bin/awk '/title/{getline; print}' | \
                      ${coreutils}/bin/cut -d'"' -f2)"
            if [ "$STRING" != " - " ];
            then
                echo " $STRING"
            else
                echo " spotify"
            fi
          ''
        );
      };
    };

    enable = true;
    package = pkgs.polybar.override {
      i3GapsSupport = true;
      alsaSupport = true;
      githubSupport = true;
    };

    script = ''
      # Run polybar on every connected monitor.
      for m in $(${pkgs.xlibs.xrandr}/bin/xrandr --query | \
                 ${pkgs.gnugrep}/bin/grep " connected" | \
                 ${pkgs.coreutils}/bin/cut -d" " -f1); do
        MONITOR=$m polybar --reload ${barName} &
      done
    '';
  };
}
