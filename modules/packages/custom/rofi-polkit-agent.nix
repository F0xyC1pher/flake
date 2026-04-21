{
	pkgs,
	inputs,
	...
}: let
	rofi-polkit-script = builtins.readFile (inputs.rofi-polkit-agent + "/rofi-polkit-agent");
in
	pkgs.writeShellScriptBin "rofi-polkit-agent" ''
		export PATH=${pkgs.lib.makeBinPath (with pkgs; [
					rofi
					gawk
					gnused
					polkit
					coreutils
					jq
					cmd-polkit
				])}:$PATH

		${rofi-polkit-script}
	''
