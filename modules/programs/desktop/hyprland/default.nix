{
	inputs,
	vars,
	pkgs,
	...
}: {
	imports = [
		./config
	];
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			enable = true;
			package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
			xwayland.enable = true;
			configType = "lua";
		};
	};
}
