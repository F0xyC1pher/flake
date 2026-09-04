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
					set -gx fish_greeting
          if not set -q __tide_configured
            tide configure --auto \
              --style=Rainbow \
              --prompt_colors='True color' \
              --show_time='24-hour format' \
              --rainbow_prompt_separators=Angled \
              --powerline_prompt_heads=Sharp \
              --powerline_prompt_tails=Flat \
              --powerline_prompt_style='One line' \
              --prompt_spacing=Compact \
              --icons='Many icons' \
              --transient=Yes > /dev/null 2>&1
            set -U __tide_configured 1
          end
				'';
				shellAliases = {
					# ls = "eza --icons";
					# ll = "eza -la --icons";
					# lt = "eza --tree --icons";
					# cat = "bat";
					# grep = "rg";
					yy = "yazi";
					gs = "git status";
					gl = "git log --oneline";
				};
				plugins = [
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
