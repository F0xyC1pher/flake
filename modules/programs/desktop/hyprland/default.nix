{
	inputs,
	pkgs,
	vars,
	...
}: {
	imports = [
		./config
	];
	programs.hyprland = {
		enable = true;
		# set the flake package
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		# make sure to also set the portal package, so that they are in sync
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};

	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			enable = true;
			package = null;
			portalPackage = null;
			xwayland.enable = true;
			configType = "lua";
			systemd = {
				enable = false;
				variables = ["--all"];
			};
		};
	};
}
