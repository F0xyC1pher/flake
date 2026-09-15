{
	vars,
	lib,
	...
}: let
	cleanHex = hex: lib.removePrefix "#" hex;
	accentShadow = "0x${vars.theme.opacityHex}${cleanHex vars.theme.style.accent}";
	overlayShadow = "0x${vars.theme.opacityHex}${cleanHex vars.theme.style.ui.overlay}";
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
									brightness = 1,
									contrast = 1.0,
									ignore_opacity = false,
									input_methods = false,
									input_methods_ignorealpha = 0.2,
									new_optimizations = true,
									popups = true	,
									popups_ignorealpha = 0.0,
									special = true,
									variant	= "prism",
									vibrancy_darkness = 0.0,
									xray = false,
									glass = {
										refraction = 20.00,
										roughness = 1.0,
										size = 128.0,
									},
									aurora = {
										color1 = 0x56c65656,
										color2 = 0x56c6c656,
										intensity = 0.4,
										speed = 10.0,
									},
								},
								glow = {
									enabled	=	true,
									color	=	0x36c65656	,
									color_inactive	=	0x56262626	,
									range	=	60	,
									render_power	=	4,
								},
								wobble = {
									enabled	= true,
									mesh	=	12,
									stiffness	=	200,
									damping	=	12,
									mass	=	1,
									intensity	=	0.2,
									value_epsilon	=	0.25,
									velocity_epsilon	=	2,
								},
								motion_blur = {
									enabled = true,
									samples	= 7,
								},
								${lib.optionalString vars.theme.shadows.enable ''
								shadow = {
									enabled = true,
									range = 20,
									render_power = 4,
									offset = {0, 0},
									color = ${
									if vars.theme.shadows.neon
									then "${accentShadow}"
									else "${overlayShadow}"
								},
									color_inactive = ${overlayShadow},
									scale = 1.0	,
									sharp = false,
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
