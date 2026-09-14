{
	vars,
	lib,
	...
}: let
	cleanHex = hex: lib.removePrefix "#" hex;
	accentShadow = "rgba(${cleanHex vars.theme.style.accent}${vars.theme.opacityHex})";
	overlayShadow = "rgba(${cleanHex vars.theme.style.ui.overlay}${vars.theme.opacityHex})";
in {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"02-decorations" = {
					autoLoad = true;
					content = ''
						hl.config({
							decoration = {
								rounding = ${toString vars.theme.border.radius},
								blur = {
									enabled = ${lib.boolToString vars.theme.blur.enable},
									size = ${toString vars.theme.blur.settings.offset},
									passes = ${toString vars.theme.blur.settings.passes},
									noise = ${toString vars.theme.blur.settings.noise},
									vibrancy = ${toString vars.theme.blur.settings.saturation},
									xray = ${lib.boolToString vars.theme.blur.xray.enable},
								},
								${lib.optionalString vars.theme.shadows.enable ''
								shadow = {
									enabled = true,
									range = 16,
									render_power = 2,
									color = ${
									if vars.theme.shadows.neon
									then ''"${accentShadow}"''
									else ''"${overlayShadow}"''
								}
								},
							''}
							},
						})
					'';
				};
			};
		};
	};
}
