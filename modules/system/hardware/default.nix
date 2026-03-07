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
	];

	hardware.parallels.enable = true;
}
