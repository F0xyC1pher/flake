# modules/themes/theMe/default.nix
{
	colors,
	accentName ? "0",
}: let
	accentHex = colors.accent.${accentName};
	onAccentHex = colors.onAccent.${accentName};
in {
	# Экспортируем акцент по умолчанию для автовыбора
	defaultAccent = "0";

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
			active = accentHex;
			"1" = accentHex;
			inactive = colors.base."3";
			"0" = colors.base."3";
		};
	};

	accent = accentHex;

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

		onAccent = onAccentHex;

		syntax = {
			keyword = colors.accent."r";
			number = colors.accent."3";
			function = colors.accent."l";
			string = colors.accent."c";
			error = colors.accent."i";
			info = colors.accent."l";
			warning = colors.accent."6";
			success = colors.accent."u";
		};
	};
}
