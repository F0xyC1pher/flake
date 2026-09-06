{vars, ...}: {
	home-manager.users.${vars.user.name}.xdg.configFile."niri/blur.kdl".text = ''
		// syntax: kdl
		blur {
			passes 5
			offset 1
			noise 0
			saturation 1
		}
	'';
}
