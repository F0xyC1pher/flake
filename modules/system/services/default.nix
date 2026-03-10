{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}:
{
	imports = [
		# ./awww-daemon-s.nix
		./awww-daemon-s-test.nix
		# ./awww-restore-s.nix
		# ./awww-path-trigger.nix
		./rofi-polkit-s.nix
		# ./swaync-s.nix
		# ./waybar-s.nix
	];
}
