{vars, ...}: {
	home-manager.users.${vars.user.name}.xdg.configFile."niri/blur.kdl".text = ''
		// syntax: kdl
		blur {
			passes ${vars.theme.blur.settings.passes}
			offset ${vars.theme.blur.settings.offset}
			noise ${vars.theme.blur.settings.noise}
			saturation ${vars.theme.blur.settings.saturation}
		}
	'';
}
