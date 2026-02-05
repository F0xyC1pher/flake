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
		./bluetooth.nix
		# ./development
		# ./gaming
	];
}
