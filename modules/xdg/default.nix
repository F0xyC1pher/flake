{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./mime.nix
		./portal.nix
		./xdg.nix
		# ./development
		# ./gaming
	];
}
