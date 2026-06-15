{vars, ...}: {
	home-manager.users.${vars.user.name}.xdg.configFile."niri/blur.kdl".text = ''
		// syntax: kdl
		blur {
			passes 3
			offset 3
			noise 0.02
			saturation 1.5
		}
	'';
}
