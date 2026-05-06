# ── Theme: cicada — role mapping ─────────────────────────────────────────────
{colors, ...}: {
	ui = {
		deep = colors.base."0";
		"0" = colors.base."0";
		main = colors.base."1";
		"1" = colors.base."1";
		surface = colors.base."2";
		"2" = colors.base."2";
		overlay = colors.base."3";
		"3" = colors.base."3";
		selection = colors.base."4";
		"4" = colors.base."4";
		highlight = colors.base."5";
		"5" = colors.base."5";

		border = {
			active = colors.accent.red;
			inactive = colors.base."3";
		};
	};

	accent = colors.accent.red;

	text = {
		comment = colors.base."6";
		separator = colors.base."7";
		indent = colors.base."8";

		submerged = colors.base."9";
		faint = colors.base."a";
		sub-main = colors.base."b";
		dimmed = colors.base."c";
		main = colors.base."d";
		primary = colors.base."d";
		highlight = colors.base."e";
		heading = colors.base."f";

		onAccent = colors.accent.green;
		match = colors.accent.green;

		syntax = {
			keyword = colors.accent.purple;
			number = colors.accent.orange;
			function = colors.accent.blue;
			string = colors.accent.green;
			error = colors.accent.cyan;
			info = colors.accent.blue;
			warning = colors.accent.yellow;
			success = colors.accent.pink;
			match = colors.accent.purple;
		};
	};
}
