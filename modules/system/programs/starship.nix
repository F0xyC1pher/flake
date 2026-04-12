{
	lib,
	vars,
	...
}: {
	programs.starship.enable = true;
	programs.starship.transientPrompt.enable =
		lib.mkIf (vars.shell == "fish") true;
}
