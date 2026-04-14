{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {vars, ...}: {
			programs.waybar.style = ''
				* {
				  font-family: ${vars.fontName}, "Source Han Sans JP";
				  font-weight: 600;
				  font-size: 15px;          /* чуть меньше, чтобы лучше влезало в высоту 56 */
				  border-radius: 0px;
				}

				window#waybar {
				  background: transparent;
				  color: ${vars.style.theme.fgMain};
				}

				window#waybar > box {
				  background: ${vars.style.theme.bgMain};
				  border-bottom: 1px solid ${vars.style.theme.surface4};
				  padding: 0 8px;
				}

				/* ===================================
				             COMMON MODULE STYLE
				   =================================== */
				#backlight,
				#wireplumber,
				#wireplumber.source,           /* для wireplumber#source */
				#language,
				#bluetooth,
				#network,
				#cpu,
				#memory,
				#clock,
				#custom-notification,
				#tray,
				#battery {
				  border: 1px solid ${vars.style.theme.surface4};
				  background: ${vars.style.theme.surface3};
				  color: ${vars.style.theme.fgMain};
				  padding: 0 12px;
				  margin: 4px 3px;
				  min-height: 32px;
				}

				/* Hover эффект */
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
				#battery:hover {
				  border: 1px solid ${vars.style.theme.surface5};
				  background: ${vars.style.theme.surface5};
				  color: ${vars.style.theme.brightText};
				  transition: all 0.2s ease;
				}

				/* ===================================
				                WORKSPACES (niri)
				   =================================== */
				#workspaces {
				  border: none;
				  background: transparent;
				  margin: 4px 3px;
				  padding: 0;
				}

				#workspaces button {
				  border: 1px solid ${vars.style.theme.surface4};
				  background: ${vars.style.theme.surface3};
				  color: ${vars.style.theme.fgMain};
				  margin: 0 3px;
				  padding: 0 14px;
				  min-height: 32px;
				  font-size: 18px;   /* японские цифры лучше смотрятся крупнее */
				}

				#workspaces button.empty {
				  border: 1px solid transparent;
				  background: transparent;
				  color: ${vars.style.theme.subtext};
				}

				#workspaces button.active {
				  border: 1px solid ${vars.style.theme.accent};
				  background: ${vars.style.theme.accent};
				  color: ${vars.style.theme.bgMain};   /* тёмный текст на красном акценте */
				}

				#workspaces button.active:hover {
				  border: 1px solid ${vars.style.theme.brightText};
				  background: ${vars.style.theme.accent};
				  color: ${vars.style.theme.bgMain};
				  transition: all 0.2s ease;
				}

				#workspaces button:hover {
				  border: 1px solid ${vars.style.theme.surface5};
				  background: ${vars.style.theme.surface5};
				  color: ${vars.style.theme.brightText};
				  transition: all 0.2s ease;
				}

				/* ===================================
				                STATE COLORS
				   =================================== */
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

				/* ===================================
				                CUSTOM NOTIFICATION
				   =================================== */
				#custom-notification {
				  font-size: 18px;
				}

				/* Убираем ненужные бордеры у tray */
				#tray {
				  border: 1px solid ${vars.style.theme.surface4};
				  background: ${vars.style.theme.surface3};
				}

				/* Чуть больше отступов для clock, т.к. там календарь */
				#clock {
				  min-width: 110px;
				}
			'';
		};
	};
}
