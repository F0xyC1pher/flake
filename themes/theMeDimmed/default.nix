# modules/themes/theMe/default.nix
{
	lib,
	colors,
	# Теперь выбираем уровень яркости акцента и конкретный цвет
	accentLevel ? "normal", # "dimmed" | "normal" | "bright"
	accentColor ? "red", # "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "purple" | "magenta"
}: let
	accentHex = colors.accent.bg.${accentLevel}.${accentColor};
	onAccentHex = colors.accent.fg.${accentLevel}.${accentColor};

	# Короткие алиасы для синтаксиса (используем яркие акценты)
	syntaxAccents = colors.accent.bg.bright;
in {
	defaultAccent = {
		level = "normal";
		color = "red";
	};

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
		comment = colors.base."5";
		separator = colors.base."6";
		indent = colors.base."7";
		submerged = colors.base."a";
		faint = colors.base."b";
		status = colors.base."c";
		dimmed = colors.base."d";
		main = colors.base."e";
		primary = colors.base."e";
		heading = colors.base."f";

		onAccent = onAccentHex;

		syntax = {
			keyword = syntaxAccents.purple;
			number = syntaxAccents.orange;
			function = syntaxAccents.blue;
			string = syntaxAccents.green;
			error = syntaxAccents.red;
			info = syntaxAccents.cyan;
			warning = syntaxAccents.yellow;
			success = syntaxAccents.green;
			match = syntaxAccents.magenta;
		};
	};
}
