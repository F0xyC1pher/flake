# ── Console colors ────────────────────────────────────────────────────────────
# Replaces stylix.targets.console. Sets the 16 VT color slots from the raw
# palette. NixOS console.colors takes hex strings WITHOUT the leading #.
{
	lib,
	vars,
	pkgs,
	...
}: let
	hex = s: lib.removePrefix "#" s;
	c = vars.theme.colors.accent;
	t = vars.theme.style;
in {
	console = {
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
		packages = with pkgs; [terminus_font];
		useXkbConfig = true;
		earlySetup = true;

		colors = [
			# Normal (0-7)
			(hex t.ui."0") # 0  Black   → deepest bg
			(hex c.red) # 1  Red
			(hex c.green) # 2  Green
			(hex c.yellow) # 3  Yellow
			(hex c.blue) # 4  Blue
			(hex c.purple) # 5  Magenta
			(hex c.cyan) # 6  Cyan
			(hex t.text.main) # 7  White   → primary text

			# Bright (8-15)
			(hex t.ui."4") # 8  Bright Black  → selection bg
			(hex c.red) # 9  Bright Red
			(hex c.green) # 10 Bright Green
			(hex c.yellow) # 11 Bright Yellow
			(hex c.blue) # 12 Bright Blue
			(hex c.purple) # 13 Bright Magenta
			(hex c.cyan) # 14 Bright Cyan
			(hex t.text.heading) # 15 Bright White  → headings
		];
	};
}
