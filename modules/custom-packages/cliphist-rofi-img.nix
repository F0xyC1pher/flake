{
	pkgs,
	inputs,
	...
}: let
	cliphist-rofi-script = builtins.readFile (inputs.cliphist + "/contrib/cliphist-rofi-img");
in
	pkgs.writeShellScriptBin "cliphist-fuzzel-img" ''
		  export PATH=${pkgs.lib.makeBinPath (with pkgs; [
					cliphist
					rofi
					gawk
					wl-clipboard
					coreutils
					findutils
					xdg-utils
				])}:$PATH

		${cliphist-rofi-script}
	''
