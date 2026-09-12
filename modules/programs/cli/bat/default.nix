{vars, ...}: {
	imports = [./theme.nix];
	home-manager.users.${vars.user.name}.programs.bat = {
		enable = true;
		syntaxes = {};
		config = {
			theme = "custom";
		};
	};
}
