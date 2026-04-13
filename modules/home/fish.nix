{
	inputs,
	vars,
	lib,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			programs.fish =
				lib.mkIf (vars.shell == "fish") {
					enable = true;
					interactiveShellInit = ''
						set fish_greeting # Disable greeting
					'';
					plugins = [
						# Enable a plugin (here grc for colorized command output) from nixpkgs
						{
							name = "grc";
							src = pkgs.fishPlugins.grc.src;
						}
					];
				};
		};
	};
}
