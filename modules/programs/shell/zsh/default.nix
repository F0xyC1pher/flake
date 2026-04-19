{
	inputs,
	vars,
	...
}: {
	# imports = [
	# 	./pk10k.nix
	# ];
	programs.zsh = {
		enable = true;
	};
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.userName} = {lib, ...}: {
			xdg.configFile."zsh/.p10k.zsh".source = ./.p10k.zsh;

			programs.zsh = {
				enable = true;
				enableCompletion = true;
				autocd = true;
				autosuggestion.enable = true;
				syntaxHighlighting.enable = true;
				history.size = 10000;
				initContent =
					lib.mkBefore ''
						[[ ! -f /home/${vars.userName}/zsh/.p10k.zsh ]] || source /home/${vars.userName}/zsh/.p10k.zsh
					'';
				zplug = {
					enable = true;
					plugins = [
						{name = "zsh-users/zsh-autosuggestions";} # Simple plugin installation
						{
							name = "romkatv/powerlevel10k";
							tags = ["as:theme" "depth:1"];
						} # Installations with additional options. For the list of options, please refer to Zplug README.
					];
				};
			};
		};
	};
}
