{
	lib,
	vars,
	...
}: {
	programs.fish.enable =
		lib.mkIf (vars.shell == "fish") true;
}
