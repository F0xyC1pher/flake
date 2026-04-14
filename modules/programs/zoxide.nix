{
	lib,
	vars,
	...
}: {
	programs.zoxide.enableBashIntegration =
		lib.mkIf (vars.shell == "bash") true;
}
