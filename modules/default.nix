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
		./boot.nix
		./configuration.nix
		./fonts.nix
		./locale.nix
		./network.nix
		./programs.nix
		./services.nix
		./users.nix
	];

}
