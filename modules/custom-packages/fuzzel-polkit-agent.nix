{
	pkgs,
	inputs,
	...
}: let
	fuzzel-polkit-script = builtins.readFile (inputs.fuzzel-polkit-agent + "/fuzzel-polkit-agent");
in
	pkgs.writeShellScriptBin "fuzzel-polkit-agent" ''
		export PATH=${pkgs.lib.makeBinPath (with pkgs; [
					fuzzel
					gawk
					gnused
					polkit
					coreutils
					jq
					cmd-polkit
				])}:$PATH

		${fuzzel-polkit-script}
	''
