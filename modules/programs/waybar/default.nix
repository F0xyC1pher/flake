{
	inputs,
	vars,
	...
}:
# let
# 	waybarConfig = builtins.fromJSON (builtins.readFile ./config.json);
# 	waybarCss = builtins.readFile ./style.css;
# in
{
	imports = [
		./modules
		./config.nix
		./style.nix
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};

		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/config".text = ''
				include: [
					"./modules/default.json"
				],
			'';

			programs.waybar = {
				enable = true;
				systemd.enable = true;
				settings = {
					mainBar = {
						layer = "top";
						position = "top";
						height = 40;
						spacing = 3;
						"margin-bottom" = -15;

						modules-left = [
							"group/left-hidden"
							"niri/language"
						];

						modules-center = ["niri/workspaces"];

						modules-right = [
							"custom/notification"
							"network"
							"group/right-hidden"
							"clock"
							"tray"
						];
					};
				};
			};
		};
	};
}
