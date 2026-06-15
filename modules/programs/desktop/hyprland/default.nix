{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			# ========= HYPRLAND =========
			wayland.windowManager.hyprland = {
				enable = true;
			};
		};
	};
}
