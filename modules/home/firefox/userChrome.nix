{ config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.firefox = {
				profiles.${vars.userFullName} = {
					userChrome = ''
						#TabsToolbar {
							visibility: collapse !important;
						}
						/* Дополнительно, если sidebar-header от Firefox мешает */
						#sidebar-header {
							display: none !important;
						}
					'';
				};
			};
		};
	};
}

