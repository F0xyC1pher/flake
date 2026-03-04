{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./environment
		./theming
		./hardware
		./home
		./xdg
		./configuration.nix
	];

}
