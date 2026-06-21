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
									font-family: "Monocraft";
									font-weight: 600;
									font-size: 14px;
									border-radius: 0px;
				}

				window#waybar {
									background: transparent;
									color: #d6d6d6;
				}

				window#waybar > box {
									background: alpha(#360606, 0.33);
									border-bottom: 2px solid #f69696;
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
				#wireplumber.source {
									border: none;
									background: none;
									color: #d6d6d6;
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
				#wireplumber.source:hover {
									/*border: 1px solid #764646;*/
									/*background: #763636;*/
									color: #f6f6f6;
									transition: all 666ms ease;
				}

				/* WORKSPACES */
				#workspaces {
									background: transparent;
									margin: 3px 2px;
				}

				#workspaces button {
									border: none;
									background: none;
									color: #f69696;
									margin: 0 2px;
									padding: 0 12px;
									min-height: 28px;
									font-size: 17px;
				}

				#workspaces button.empty {
									border: none;
									background: transparent;
									color: #666666;
				}

				#workspaces button.active {
									border: none;
									background: #f69696;
									color: #360606;
				}

				#workspaces button.active:hover {
									border: none;
									background: #f6f6f6;
									color: #360606;
				}

				#workspaces button:hover {
									border: none;
									background: none;
									color: #f6f6f6;
				}

				/* STATE COLORS */
				#battery.warning {
									border-color: #f6f696;
									color: #f6f696;
				}

				#battery.critical {
									border-color: #96f6f6;
									color: #96f6f6;
				}

				#wireplumber.muted,
				#wireplumber.source.muted {
									color: #a6a6a6;
				}

				#custom-notification {
									font-size: 17px;
				}

				#tray {
									border: none;
									background: none;
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
