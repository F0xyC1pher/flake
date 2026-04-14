{
	inputs,
	vars,
	lib,
	...
}: {
	programs.fish.enable =
		lib.mkIf (vars.shell == "fish") true;
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {pkgs, ...}: {
			programs.fish =
				lib.mkIf (vars.shell == "fish") {
					enable = true;
					interactiveShellInit = ''
						set fish_greeting # Disable greeting
					'';
					shellAbbrs = {
						rgrc = "grc";
					};
					shellAliases = {
						rgrc = "grc";
					};
					plugins = [
						# Enable a plugin (here grc for colorized command output) from nixpkgs

						{
							name = "autopair";
							src = pkgs.fishPlugins.autopair.src;
						}
						{
							name = "bobthefisher";
							src = pkgs.fishPlugins.bobthefisher.src;
						}
						{
							name = "fifc";
							src = pkgs.fishPlugins.fifc.src;
						}
						{
							name = "forgit";
							src = pkgs.fishPlugins.forgit.src;
						}
						{
							name = "fzf";
							src = pkgs.fishPlugins.fzf.src;
						}
						# {
						# 	name = "tide";
						# 	src = pkgs.fishPlugins.tide.src;
						# }
						# {
						# 	name = "transient-fish";
						# 	src = pkgs.fishPlugins.transient-fish.src;
						# }
						{
							name = "grc";
							src = pkgs.fishPlugins.grc.src;
						}
					];
				};
		};
	};
}
