{vars, ...}: {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"06-outputs" = {
					autoLoad = true;
					content = ''
						hl.monitor({
						  output = "${vars.host.hardware.video.output.name}",
						  mode = "${vars.host.hardware.video.output.resolution}@${vars.host.hardware.video.output.framerate}",
						  position = "0x0",
						  scale = "1"
						})
					'';
				};
			};
		};
	};
}
