{
	inputs,
	vars,
	...
}: {
	services.flatpak = {
		enable = true;
	};
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			services.flatpak = {
				enable = true;
				packages = [
					{
						appId = "org.vinegarhq.Sober";
						origin = "flathub";
					}
				];

				update = {
					auto = {
						enable = true;
						onCalendar = "weekly";
					};
				};
			};
		};
	};
}
