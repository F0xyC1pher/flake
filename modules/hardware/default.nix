{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./nvidia
		./redist.nix
	];

	hardware.parallels.enable = true;
}
