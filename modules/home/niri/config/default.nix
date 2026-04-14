{
	lib,
	vars,
	...
}: {
	imports =
		[
			./animations.nix
			./binds.nix
			./colors.nix
			./config.nix
			./debug.nix
			./input.nix
			./layer-rules.nix
			./layout.nix
			./misc.nix
			./outputs.nix
			./window-rules.nix
		]
		++ lib.optionals vars.blur.enable [./blur.nix];
}
