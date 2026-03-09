{ config, pkgs, inputs, vars, ... }:
let
  # Короткий алиас, чтобы не писать длинную строку каждый раз
  addons = inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system};
in
{
	imports = [
		./extensions.nix
		./policies.nix
		./settings.nix
		./userChrome.nix
		./userJS.nix
	];
	
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				enable = true;
				profiles.${vars.userFullName} = {
					name = "${vars.userFullName}";
					isDefault = true;
					id = 0;
				};
			};
		};
	};
}
