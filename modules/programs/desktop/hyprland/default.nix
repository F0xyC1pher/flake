{
	pkgs,
	vars,
	inputs,
	...
}: {
	programs.hyprland = {
		enable = true;
		package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
		portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
	};
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			# ========= HYPRLAND =========
			wayland.windowManager.hyprland.systemd.variables = ["--all"];
			wayland.windowManager.hyprland = {
				enable = true;
				package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
				portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
			};
		};
	};
}
