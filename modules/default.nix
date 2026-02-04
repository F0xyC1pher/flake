{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./configuration.nix
		./xdg.nix
		./apps.nix
		./nvidia.nix
		# ./development
		# ./gaming
	];
}
