{
	pkgs,
	vars,
	...
}: {
	environment.shells = [
		pkgs.${vars.shell}
	];
}
