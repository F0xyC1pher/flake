{
	pkgs,
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {...}: {
			programs.firefox = {
				profiles.${vars.userFullName} = {
					extensions.force = true;
					extensions.packages = with pkgs.firefoxAddons; [
						ublock-origin
						sponsorblock
						return-youtube-dislikes
						stylus
						violentmonkey
						keepassxc-browser
						sidebery
					];
				};
			};
		};
	};
}
