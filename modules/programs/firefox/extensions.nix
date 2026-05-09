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
							sidebery
							tap-to-tab
							ublock-origin
							violentmonkey
							v3-get-old-youtube-layout
							dont-touch-my-selection
							return-youtube-dislikes
							s3_translator
							keepassxc-browser
							horizontal-scroll
							firefox-color
							sponsorblock
							# stylus
						];
					};
				};
			};
		};
	};
}
