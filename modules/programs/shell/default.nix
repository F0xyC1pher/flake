{
	vars,
	pkgs,
	...
}: {
	imports = [
		./${vars.shell}.nix
	];
	environment.shells = [
		pkgs.${vars.shell}
	];
}
