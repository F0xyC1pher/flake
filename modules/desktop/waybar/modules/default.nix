{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."waybar/modules/default.json".text = ''
				// syntax: json
				{
					"include": [
						"./modules/custom/arrow-left.json",
						"./modules/custom/arrow-right.json",
						"./modules/custom/notification.json",
						"./modules/group/left-hidden.json",
						"./modules/group/right-hidden.json",
						"./modules/backlight.json",
						"./modules/battery.json",
						"./modules/clock.json",
						"./modules/cpu.json",
						"./modules/disk.json",
						"./modules/memory.json",
						"./modules/network.json",
						"./modules/niri.json",
						"./modules/tray.json",
						"./modules/wireplumber.json",
					],
				}
			'';
		};
	};
	imports = [
		./custom/arrow-left.nix
		./custom/arrow-right.nix
		./custom/notification.nix
		./group/left-hidden.nix
		./group/right-hidden.nix
		./backlight.nix
		./battery.nix
		./clock.nix
		./cpu.nix
		./disk.nix
		./memory.nix
		./network.nix
		./niri.nix
		./tray.nix
		./wireplumber.nix
	];
}
