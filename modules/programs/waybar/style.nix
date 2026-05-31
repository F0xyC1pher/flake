{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {vars, ...}: {
			programs.waybar.style = ''
				/*css*/
				* {
				  font-family: ${vars.theme.font.name}, "Source Han Sans JP";
				  font-weight: 600;
				  font-size: 14px;
				  border-radius: 0px;
				}

				window#waybar {
				  background: transparent;
				  color: ${vars.theme.style.text.primary};
				}

				window#waybar > box {
				  background: alpha(${vars.theme.style.ui."0"}, 0.33);
				  border-bottom: 1px solid ${vars.theme.style.ui."4"};
				  padding: 0 6px;
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
				#wireplumber.source
				{
				  border: 1px solid ${vars.theme.style.ui."4"};
				  background: ${vars.theme.style.ui."3"};
				  color: ${vars.theme.style.text.main};
				  padding: 0 10px;
				  margin: 3px 2px;
				  min-height: 28px;
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
				#wireplumber.source:hover
				{
				  border: 1px solid ${vars.theme.style.ui."5"};
				  background: ${vars.theme.style.ui."5"};
				  color: ${vars.theme.style.text.heading};
				  transition: all 0.25s ease;
				}

				/* WORKSPACES */
				#workspaces {
				  background: transparent;
				  margin: 3px 2px;
				}

				#workspaces button {
				  border: 1px solid ${vars.theme.style.ui."4"};
				  background: ${vars.theme.style.ui."3"};
				  color: ${vars.theme.style.text.main};
				  margin: 0 2px;
				  padding: 0 12px;
				  min-height: 28px;
				  font-size: 17px;
				}

				#workspaces button.empty {
				  border: 1px solid transparent;
				  background: transparent;
				  color: ${vars.theme.style.text.comment};
				}

				#workspaces button.active {
				  border: 1px solid ${vars.theme.style.accent};
				  background: ${vars.theme.style.accent};
				  color: ${vars.theme.style.ui."0"};
				}

				#workspaces button.active:hover {
				  border: 1px solid ${vars.theme.style.text.heading};
				  background: ${vars.theme.style.accent};
				  color: ${vars.theme.style.ui."0"};
				}

				#workspaces button:hover {
				  border: 1px solid ${vars.theme.style.ui."5"};
				  background: ${vars.theme.style.ui."5"};
				  color: ${vars.theme.style.text.heading};
				}

				/* STATE COLORS */
				#battery.warning {
				  border-color: ${vars.theme.style.text.syntax.warning};
				  color: ${vars.theme.style.text.syntax.warning};
				}

				#battery.critical {
				  border-color: ${vars.theme.style.text.syntax.error};
				  color: ${vars.theme.style.text.syntax.error};
				}

				#wireplumber.muted,
				#wireplumber.source.muted {
				  color: ${vars.theme.style.text.faint};
				}

				#custom-notification {
				  font-size: 17px;
				}

				#tray {
				  border: 1px solid ${vars.theme.style.ui."4"};
				  background: ${vars.theme.style.ui."3"};
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
