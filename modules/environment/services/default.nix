{
	inputs,
	config,
	vars,
	pkgs,
	...
}: {
	imports = [
		./awww-daemon.nix
		./rofi-polkit.nix
	];
}
