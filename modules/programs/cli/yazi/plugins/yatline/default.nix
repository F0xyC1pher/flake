{vars, ...}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {pkgs, ...}: {
			programs.yazi.plugins.yatline = {
				package = pkgs.yaziPlugins.yatline;
				setup = true;
				settings = {
					tab_width = 20;
				};
			};
		};
	};
}
