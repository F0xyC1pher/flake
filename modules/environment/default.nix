{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./packages-custom.nix
		./packages.nix
		./services.nix
		./variables.nix
	];
}
