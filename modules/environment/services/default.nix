{
	inputs,
	config,
	vars,
	pkgs,
	...
}: {
	imports = [
		./awww-daemon.nix
		./awww-restore.nix
		./rofi-polkit.nix
	];
}
