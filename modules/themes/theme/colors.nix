# ── Theme: theme — colors (chaos zone) ───────────────────────────────────────
#
# Pure color set. Names here can be ANYTHING — base."0", red, maroon, hellfire.
# This file does NOT define UI semantics. It only declares which hex values
# this theme has access to. Role mapping happens in ./theme.nix.
#
# Layout:
#   base."0" .. base."f"  — 16-step grayscale ramp, dark → light
#   accent.<name>          — 8 named accent colors
{
	base = {
		"0" = "#060606"; # darkest — behind glass / blur
		"1" = "#161616"; # window background
		"2" = "#262626"; # panels, statusbars
		"3" = "#363636"; # floating windows / inactive borders
		"4" = "#464646"; # text selection background
		"5" = "#565656"; # current-line highlight
		"6" = "#666666"; # comments
		"7" = "#767676"; # separators
		"8" = "#868686"; # indent guides
		"9" = "#969696"; # icon text / inactive tabs
		"a" = "#a6a6a6"; # secondary info (file sizes)
		"b" = "#b6b6b6"; # statusbar text
		"c" = "#c6c6c6"; # near-primary text
		"d" = "#d6d6d6"; # primary reading text
		"e" = "#e6e6e6"; # bold / highlighted text
		"f" = "#f6f6f6"; # pure light — headings
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
