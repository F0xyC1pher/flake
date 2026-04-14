{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {vars, ...}: {
			programs.waybar.style = ''
				/*css*/
				* {
				  font-family: ${vars.fontName}, "Source Han Sans JP";
				  font-weight: 600;
				  font-size: 14px;
				  border-radius: 0px;
				}

				window#waybar {
				  background: transparent;
				  color: ${vars.style.theme.fgMain};
				}

				window#waybar > box {
				  background: rgba(22, 22, 22, 0.6);
				  border-bottom: 1px solid ${vars.style.theme.surface4};
				  padding: 0 6px;
				}

				/* COMMON MODULE STYLE */
				#backlight,
				#wireplumber,
				#wireplumber.source,
				#language,
				#bluetooth,
				#network,
				#cpu,
				#memory,
				#clock,
				#custom-notification,
				#tray,
				#battery,
				#custom-arrow-left,
				#custom-arrow-right {
				  border: 1px solid ${vars.style.theme.surface4};
				  background: ${vars.style.theme.surface3};
				  color: ${vars.style.theme.fgMain};
				  padding: 0 10px;
				  margin: 3px 2px;
				  min-height: 28px;
				}

				/* Hover */
				#backlight:hover,
				#wireplumber:hover,
				#wireplumber.source:hover,
				#language:hover,
				#bluetooth:hover,
				#network:hover,
				#cpu:hover,
				#memory:hover,
				#clock:hover,
				#custom-notification:hover,
				#tray:hover,
				#battery:hover,
				#custom-arrow-left:hover,
				#custom-arrow-right:hover {
				  border: 1px solid ${vars.style.theme.surface5};
				  background: ${vars.style.theme.surface5};
				  color: ${vars.style.theme.brightText};
				  transition: all 0.25s ease;
				}

				/* WORKSPACES */
				#workspaces {
				  background: transparent;
				  margin: 3px 2px;
				}

				#workspaces button {
				  border: 1px solid ${vars.style.theme.surface4};
				  background: ${vars.style.theme.surface3};
				  color: ${vars.style.theme.fgMain};
				  margin: 0 2px;
				  padding: 0 12px;
				  min-height: 28px;
				  font-size: 17px;
				}

				#workspaces button.empty {
				  border: 1px solid transparent;
				  background: transparent;
				  color: ${vars.style.theme.subtext};
				}

				#workspaces button.active {
				  border: 1px solid ${vars.style.theme.accent};
				  background: ${vars.style.theme.accent};
				  color: ${vars.style.theme.bgMain};
				}

				#workspaces button.active:hover {
				  border: 1px solid ${vars.style.theme.brightText};
				  background: ${vars.style.theme.accent};
				  color: ${vars.style.theme.bgMain};
				}

				#workspaces button:hover {
				  border: 1px solid ${vars.style.theme.surface5};
				  background: ${vars.style.theme.surface5};
				  color: ${vars.style.theme.brightText};
				}

				/* STATE COLORS */
				#battery.warning {
				  border-color: ${vars.style.theme.warning};
				  color: ${vars.style.theme.warning};
				}

				#battery.critical {
				  border-color: ${vars.style.theme.error};
				  color: ${vars.style.theme.error};
				}

				#wireplumber.muted,
				#wireplumber.source.muted {
				  color: ${vars.style.theme.subtext};
				}

				#custom-notification {
				  font-size: 17px;
				}

				#tray {
				  border: 1px solid ${vars.style.theme.surface4};
				  background: ${vars.style.theme.surface3};
				}

				#clock {
				   min-width: 80px;
				}
				#cpu,
				#memory {
					 min-width: 50px;
				}
			'';
		};
	};
}
