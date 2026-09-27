{
	vars,
	inputs,
	...
}: {
	imports = [./theme.nix];
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			programs.yazi.plugins.yatline = {
				package = inputs.yatline-foxy;
				setup = true;
				settings = {
					tab_width = 20;
				};
			};
		};
	};
}
