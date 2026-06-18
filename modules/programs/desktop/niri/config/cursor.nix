{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/cursor.kdl".text = ''
				// syntax: kd
				cursor {
					xcursor-theme "Posy_Cursor_Black"
					xcursor-size 32
				}
			'';
		};
	};
}
