{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./boot.nix
		./nvidia.nix
		./application-profiles.nix
		./persistence-mode-max-perf.nix
	];
}
