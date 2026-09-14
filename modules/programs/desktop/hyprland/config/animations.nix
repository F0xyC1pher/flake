{vars, ...}: {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"00-animations" = {
					autoLoad = true;
					content = ''
					hl.config({
						animations = {
				    	enabled = true,
						},
					})
						hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
						hl.curve("default", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

						hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "default" })
						hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "linear", style = "slide" })
						hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "default" })
					'';
				};
			};
		};
	};
}
