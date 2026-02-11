{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./packages-custom.nix
		./packages.nix
		./variables.nix
	];
}
