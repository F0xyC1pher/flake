{
	inputs,
	pkgs,
	vars,
	...
}: {
	programs.fish = {
		enable = true;
		useBabelfish = true;
	};
	imports = [
		./theme.nix
	];
	environment.shells = with pkgs; [
		fish
	];
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.fish = {
				enable = true;
				interactiveShellInit = ''
					tput cup (tput lines) 0
					set -gx fish_greeting # Disable greeting
				'';
				plugins = [
					# Enable a plugin (here grc for colorized command output) from nixpkgs

					{
						name = "autopair";
						src = pkgs.fishPlugins.autopair.src;
					}
					# {
					# 	name = "transient-fish";
					# 	src = pkgs.fishPlugins.transient-fish.src;
					# }
					{
						name = "tide";
						src = pkgs.fishPlugins.tide.src;
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
					{
						name = "grc";
						src = pkgs.fishPlugins.grc.src;
					}
				];
			};
		};
	};
}
