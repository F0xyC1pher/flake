{
	config,
	pkgs,
	inputs,
	...
}: {
	imports = [
		./options.nix
		./apps.nix
		# ./themes
		# ./hyprland
		# ./waybar
		# ./walker
		# ./rofi
	];

	# home.file."${config.wallpapersDir}" = {
	#     source = ./wallpapers;
	# };
}
