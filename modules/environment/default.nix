{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./packages.nix
		./variables.nix
	];
}
