{
	vars,
	lib,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit vars;};
		users.${vars.user.name} = {...}: {
			programs.nix-your-shell = {
				enable = true;

				# Optional: Enable for selected shells. Default: `home.shell.enable<Shell>Integration`.
				enableFishIntegration = vars.hasProgram "fish";
				enableNushellIntegration = vars.hasProgram "nushell";
				enableZshIntegration = vars.hasProgram "zsh";

				# Optional: Whether to pipe the build output through nix-output-monitor. Default: false.
				nix-output-monitor.enable = true;
			};
		};
	};
}
