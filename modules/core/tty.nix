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
	t = vars.theme.style;
	c.a = {
		n = vars.theme.colors.accent.bg.normal;
		b = vars.theme.colors.accent.bg.bright;
	};
	c.b = vars.theme.colors.base;
in {
	console = {
		font = "${pkgs.terminus_font}/share/consolefonts/ter-v14n.psf.gz";
		packages = with pkgs; [terminus_font];
		useXkbConfig = true;
		earlySetup = true;

		colors = [
			# Normal (0-7)
			(hex c.b."2") # 0  Black   → deepest bg
			(hex c.a.n.red) # 1  Red
			(hex c.a.n.green) # 2  Green
			(hex c.a.n.yellow) # 3  Yellow
			(hex c.a.n.blue) # 4  Blue
			(hex c.a.n.magenta) # 5  Magenta
			(hex c.a.n.cyan) # 6  Cyan
			(hex t.text.main) # 7  White   → primary text

			# Bright (8-15)
			(hex c.b."3") # 8  Bright Black  → selection bg
			(hex c.a.b.red) # 9  Bright Red
			(hex c.a.b.green) # 10 Bright Green
			(hex c.a.b.yellow) # 11 Bright Yellow
			(hex c.a.b.blue) # 12 Bright Blue
			(hex c.a.b.magenta) # 13 Bright Magenta
			(hex c.a.b.cyan) # 14 Bright Cyan
			(hex t.text.heading) # 15 Bright White  → headings
		];
	};
}
