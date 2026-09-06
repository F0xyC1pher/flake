{
	inputs,
	pkgs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.git = {
				enable = true;
				settings = {
					user = {
						name = "${vars.user.gitName}";
						email = "${vars.user.mail}";
					};
					# extraConfig = {
					# 	"credential \"https://github.com\"".helper = "!${pkgs.gh}/bin/gh auth git-credential";
					# 	"credential \"https://gist.github.com\"".helper = "!${pkgs.gh}/bin/gh auth git-credential";
					# };
					init.defaultBranch = "master";
					pull.rebase = false;
				};
			};
		};
	};
}
