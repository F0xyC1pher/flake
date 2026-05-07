{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.firefox = {
				profiles.${vars.user.fullName} = {
					extensions = {
						force = true;
						packages = with pkgs.firefoxAddons; [
							russian-ru-language-pack
							ublock-origin
							sponsorblock
							return-youtube-dislikes
							stylus
							violentmonkey
							keepassxc-browser
							sidebery
							tap-to-tab
							s3_translator
							firefox-color
							horizontal-scroll
						];
					};
				};
			};
		};
	};
}
