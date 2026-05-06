# ── Theme: theme — colors ────────────────────────────────────────────────────
#
# Pure color set. Names here can be ANYTHING — base."0", red, maroon, hellfire.
# This file does NOT define UI semantics. Role mapping happens in ./default.nix.
#
#   base."0" .. base."f"  — 16-step grayscale ramp, dark → light
#   accent.<name>          — 8 named accent colors
{
	base = {
		"0" = "#060606";
		"1" = "#161616";
		"2" = "#262626";
		"3" = "#363636";
		"4" = "#464646";
		"5" = "#565656";
		"6" = "#666666";
		"7" = "#767676";
		"8" = "#868686";
		"9" = "#969696";
		"a" = "#a6a6a6";
		"b" = "#b6b6b6";
		"c" = "#c6c6c6";
		"d" = "#d6d6d6";
		"e" = "#e6e6e6";
		"f" = "#f6f6f6";
	};

	accent = {
		red = "#f67676";
		orange = "#f6b676";
		yellow = "#f6f676";
		green = "#76f676";
		cyan = "#76f6f6";
		blue = "#76a6f6";
		purple = "#b676f6";
		pink = "#f676b6";
	};
}
