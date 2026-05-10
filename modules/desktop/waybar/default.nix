{
	inputs,
	vars,
	...
}: {
	imports = [
		./modules
		./style.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};

		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/config".text = ''
				// syntax: json
					{
						"include": [
							"./modules/default.json"
						],

						"layer": "top",
						"position": "top",
						"height": 40,
						"spacing": 3,
						"margin-bottom": -15,

						"modules-left": [
							"group/left-hidden",
							"niri/language",
						],

						"modules-center": [
							"custom/notification",
							"niri/workspaces",
						],

						"modules-right": [
							"group/right-hidden",
							"clock",
							"tray",
						],
					}
			'';

			programs.waybar = {
				enable = true;
				systemd.enable = true;
			};
		};
	};
}
