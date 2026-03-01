{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./services
		./packages-custom.nix
		./packages.nix
		./variables.nix
	];
}
