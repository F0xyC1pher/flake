{vars, ...}: {
	home-manager.users.${vars.user.name}.xdg.configFile."niri/blur.kdl".text = ''
		// syntax: kdl
		blur {
			passes ${toString vars.theme.blur.settings.passes}
			offset ${toString vars.theme.blur.settings.offset}
			noise ${toString vars.theme.blur.settings.noise}
			saturation ${toString vars.theme.blur.settings.saturation}
		}
	'';
}
