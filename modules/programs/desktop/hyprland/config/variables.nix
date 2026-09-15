{vars, ...}: {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"07-variables" = {
					autoLoad = true;
					content = ''
						hl.env("XCURSOR_SIZE", "24")
						hl.env("HYPRCURSOR_SIZE", "24")
					'';
				};
			};
		};
	};
}
