{
	vars,
	pkgs,
	lib,
	inputs,
	...
}: {
	services.displayManager.sessionPackages =
		[]
		++ lib.optional (vars.hasProgram "niri") inputs.niri-glass.packages.${pkgs.stdenv.hostPlatform.system}.default
		++ lib.optional (vars.hasProgram "hyprland") inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.default
		++ lib.optional (vars.hasProgram "driftwm") inputs.driftwm.packages.${pkgs.stdenv.hostPlatform.system}.default
		++ lib.optional (vars.hasProgram "umbriel") inputs.umbriel.packages.${pkgs.stdenv.hostPlatform.system}.default;
}
