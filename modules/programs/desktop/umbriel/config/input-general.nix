{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel.settings = {
				general = {
					xwayland = true;
				};

				layout.gap = 5;

				input = {
					cursor = {
						hardware_cursor = true;
						follows_focus = true;
					};
					keyboard = {
						layout = "us,ru";
						options = "grp:lalt_lshift_toggle";
						repeat_rate = 60;
						repeat_delay = 250;
					};
					focus = {
						follows_mouse = true;
					};
				};
			};
		};
	};
}
