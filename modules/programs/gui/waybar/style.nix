{
  lib,
  vars,
  ...
}: {
  hjem.users.${vars.user.name}.xdg.config.files = {
    "waybar/style.css".text = ''
      /*css*/

      window#waybar {
      	background: transparent;
      	color: ${vars.theme.style.text.main};
      }

      window#waybar > box {
      	background: alpha(${vars.theme.style.ui.bg}, ${toString vars.theme.opacity});
      	border-bottom: 2px solid ${vars.theme.style.accent};
      }

      /* COMMON MODULE STYLE */
      #custom-arrow-left,
      #custom-arrow-right,
      #custom-notification,
      #backlight,
      #battery,
      #bluetooth,
      #clock,
      #cpu,
      #disk,
      #memory,
      #network,
      #language,
      #tray,
      #wireplumber,
      #wireplumber.source {
      	border: none;
      	background: none;
      	color: ${vars.theme.style.text.main};
      }

      /* Hover */
      #custom-arrow-left:hover,
      #custom-arrow-right:hover,
      #custom-notification:hover,
      #backlight:hover,
      #battery:hover,
      #bluetooth:hover,
      #clock:hover,
      #cpu:hover,
      #disk:hover,
      #memory:hover,
      #network:hover,
      #language:hover,
      #tray:hover,
      #wireplumber:hover,
      #wireplumber.source:hover {
      	color: ${vars.theme.style.text.heading};
      	transition: all 666ms ease;
      }

      /* WORKSPACES */
      #workspaces {
      	background: transparent;
      }

      #workspaces button {
      	border: none;
      	background: none;
      	color: ${vars.theme.style.accent};
      	margin: 0px;
      	padding: 0 4px;
      	min-height: 0px;
      }

      #workspaces button.empty {
      	border: none;
      	background: transparent;
      	color: ${vars.theme.style.text.comment};
      }

      #workspaces button.active {
      	border: none;
      	background: ${vars.theme.style.accent};
      	color: ${vars.theme.style.ui.bg};
      }

      #workspaces button.active:hover {
      	border: none;
      	background: ${vars.theme.style.text.heading};
      	color: ${vars.theme.style.ui.bg};
      }

      #workspaces button:hover {
      	border: none;
      	background: none;
      	color: ${vars.theme.style.text.heading};
      }

      /* STATE COLORS */
      #battery.warning {
      	border-color: ${vars.theme.style.text.syntax.warning};
      	color: ${vars.theme.style.text.syntax.warning};
      }

      #battery.critical {
      	border-color: ${vars.theme.style.text.syntax.info};
      	color: ${vars.theme.style.text.syntax.info};
      }

      #wireplumber.muted,
      #wireplumber.source.muted {
      	color: ${vars.theme.style.text.dimmed};
      }

      #custom-notification {
      	font-size: ${toString (lib.floor (vars.theme.font.size * 1.333333))}pt;
      }

      #tray {
      	border: none;
      	background: none;
      }

      #cpu,
      #memory {
      	min-width: 50px;
      }

      * {
      	font-family: "${vars.theme.font.name}";
      	font-weight: 400;
      	font-size: ${toString vars.theme.font.size}pt;
      	border-radius: 0px;
      }
    '';
  };
}
