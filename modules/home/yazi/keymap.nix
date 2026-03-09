{ lib, config, pkgs, inputs, vars, ... }:
{
	home-manager = {
		extraSpecialArgs = { inherit inputs vars; };
		users.${vars.userName} =  { config, pkgs, lib, ... }: {
			programs.yazi = {

				keymap = {
					manager.prepend_keymap = [
						# gitui
						{
							on = [ "g" "i" ];
							run = "plugin gitui";
							desc = "gitui";
						}
						
						# sudo
						{
							on = [ "!" ];
							run = "plugin sudo";
							desc = "sudo";
						}
						
						# chmod
						{
							on = [ "c" "m" ];
							run = "plugin chmod";
							desc = "chmod";
						}
						
						# compress
						{
							on = [ "c" "a" ];
							run = "plugin compress";
							desc = "compress";
						}
						
						# mediainfo
						{
							on = [ "m" "i" ];
							run = "plugin mediainfo";
							desc = "media info";
						}
						
						# mount
						{
							on = [ "M" ];
							run = "plugin mount";
							desc = "mount";
						}
						
						# toggle pane
						{
							on = [ "T" ];
							run = "plugin toggle-pane";
							desc = "toggle pane";
						}
					];
				};

			};
		};
	};
}
