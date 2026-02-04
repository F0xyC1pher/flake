{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./configuration.nix
		./hardware.nix
		./xdg.nix
		./apps.nix
		./nvidia.nix
		# ./development
		# ./gaming
	];
}
