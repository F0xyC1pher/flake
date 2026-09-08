{
	pkgs,
	inputs,
	...
}: let
	cliphist-fuzzel-script = builtins.readFile (inputs.cliphist + "/contrib/cliphist-fuzzel-img");
in
	pkgs.writeShellScriptBin "cliphist-fuzzel-img" ''
		  export PATH=${pkgs.lib.makeBinPath (with pkgs; [
					cliphist
					fuzzel
					gawk
					wl-clipboard
					coreutils
					findutils
					xdg-utils
				])}:$PATH

		${cliphist-fuzzel-script}
	''
