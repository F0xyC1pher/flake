{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {lib, ...}: {
			programs.umbriel = {
				enable = true;
				settings = {
					general.autostart = ["noctalia"];
					layout.gap = 5;
					input.keyboard = {
						layout = "us,ru";
						options = "grp:lalt_lshift_toggle";
					};
					keybinds = {
						"Mod+Return" = "spawn:kitty";
						"Mod+Q" = "window-close";
						"Mod+D" = "spawn:fuzzel";
						"Mod" = "spawn:noctalia msg panel-toggle launcher";
					};
				};
			};
		};
	};
}
