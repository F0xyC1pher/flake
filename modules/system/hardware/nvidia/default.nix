{
	config,
	pkgs,
	lib,
	inputs,
	vars,
	...
}: {
	imports = [
		./nvidia.nix
		./application-profiles.nix
		./persistence-mode-max-perf.nix
	];
}
