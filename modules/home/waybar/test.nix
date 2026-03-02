{ lib, config, pkgs, inputs, vars, ... }:
{
  programs.waybar = {
    enable = true;
	systemd.enable = true;
    # Основные параметры
    config = {
      height = 1;
      layer = "top";
      position = "bottom";

      modules-left = [
        "backlight"
        "wireplumber"
        "wireplumber#source"
        "niri/language"
        "bluetooth"
      ];

      modules-center = [ "niri/workspaces" ];

      modules-right = [
        "tray"
        "clock#time"
        "custom/clock"
        "battery"
      ];

      # Настройки модулей
      bluetooth = {
        format = "󰂯 {status}";
        format-connected = "󰂯 {device_battery_percentage}%";
        tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
        tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
        "tooltip-format-enumerate-connected-battery" = "{device_alias}\t{device_address}\t{device_battery_percentage}%";
      };

      tray = {
        "icon-size" = 18;
        spacing = 12;
      };

      battery = {
        format = "{icon} {capacity}%";
        "format-alt" = "{icon} {time} ";
        "format-charging" = "󰂅  {capacity}%";
        "format-icons" = ["󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
        states = {
          critical = 15;
          warning = 30;
        };
      };

      "battery#bat2" = {
        bat = "bat2";
      };

      "clock#time" = {
        format = "󰸘  {:%b %e}";
        "tooltip-format" = "<tt>{calendar}</tt>";
        interval = 1;
      };

      "custom/clock" = {
        exec = "date +\"  %H•%M\"";
        interval = 1;
      };

      "niri/language" = {
        format = "󰌌  {}";
        "format-en" = "en";
        "format-ru" = "ru";
        "keyboard-name" = "kanata";
        interval = 1;
      };

      "niri/workspaces" = {
        on-click = "activate";
        format = "{icon}";
        "format-icons" = {
          "1" = "一"; "2" = "二"; "3" = "三"; "4" = "四"; "5" = "五";
          "6" = "六"; "7" = "七"; "8" = "八"; "9" = "九"; "10" = "十"; "11" = "一";
        };
        "persistent-workspaces" = {
          eDP-1 = [1 2 3 4 5 6 7 8 9 10];
          DP-2  = [1 2 3 4 5 6 7 8 9 10];
        };
      };

      backlight = {
        device = "intel_backlight";
        format = "{icon} {percent}%";
        "format-icons" = [" " " "];
      };

      wireplumber = {
        format = "{icon}  {volume}%";
        "format-icons" = ["" "" ""];
        "format-muted" = "󰝟  mute";
        "on-click" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
        "scroll-step" = 3;
        "max-volume" = 100.0;
      };

      "wireplumber#source" = {
        "node-type" = "Audio/Source";
        format = "󰍬 {volume}%";
        "format-muted" = "󰍭  mute";
        "on-click-right" = "wpctl set-mute @default_audio_source@ toggle";
        "scroll-step" = 3;
      };
    };

    # Стили
    style = builtins.toString ''
      * { font-family: Inter, SourceHanSansJP; font-weight: 700; font-size: 16px; }
      window#waybar { background-color: transparent; color: #d7c4a0; }
      window#waybar > box {
        margin: 0; background-color: #16130e; border-top: 1px solid #38342b; 
        border-radius: 0; padding-right: 8px; padding-left: 8px;
      }
      #workspaces button {
        background-color: #4c4639; border-radius: 20px; margin: 2px; 
        padding: 0 5px; color: #d7c4a0; min-height: 25px; transition: all 0.4s ease-in-out;
      }
      #workspaces button label { color: #d7c4a0; font-weight: bolder; }
      #workspaces button.empty { background: #38342b; }
      #workspaces button.active {
        background: radial-gradient(circle, #d7c4a0 0%, #c88800 50%, #50462a 100%); 
        background-size: 400% 400%; animation: gradient 5s linear infinite; transition: all 0.3s ease-in-out;
        border-color: #45475a;
      }
      #workspaces button.active label { color: #4c4639; font-weight: bolder; }
      @keyframes gradient { 0% {background-position:0px 50px;} 50%{background-position:100px 30px;} 100%{background-position:0px 50px;} }
      #battery, #backlight, #clock, #wireplumber, #workspaces, #window, #language, #text, #custom-launcher, #custom-separator, #custom-clock, #tray, #image-network {
        color:#d7c4a0; background:#38342b; padding:0 0.4em; border:1px solid #4c4639; min-height:30px;
      }
      #tray { border-radius: 20 4 4 20px; margin:3px 2px; }
      #battery { border-radius: 4 20 20 4px; margin:3px 2px; }
      #backlight { border-radius: 20 4 4 20px; margin:3px 2px; }
      #clock, #custom-clock, #language, #wireplumber, #bluetooth { border-radius:4px; margin:3px 2px; }
      #custom-launcher { border-radius:0 20 20 0; padding-right:0.6em; margin:0; }
      #workspaces { border-radius:20px; margin:3px 0; }
    '';
  };
}
