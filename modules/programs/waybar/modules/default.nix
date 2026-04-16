{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			xdg.configFile."waybar/modules/default.json".text = ''
				#json
				{
					include: [
						"./custom/arrow-left.json",
						"./custom/arrow-right.json",
						"./custom/notification.json",
						"./group/left-hidden.json",
						"./group/right-hidden.json",
						"./backlight.json",
						"./battery.json",
						"./clock.json",
						"./cpu.json",
						"./memory.json",
						"./network.json",
						"./niri.json",
						"./tray.nix",
						"./wireplumber.json",
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
		./memory.nix
		./network.nix
		./niri.nix
		./tray.nix
		./wireplumber.nix
	];
}
