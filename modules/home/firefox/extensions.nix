{ config, pkgs, inputs, vars, ... }:
let
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				profiles.${vars.userFullName} = {
					extensions.packages = with addons; [
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

