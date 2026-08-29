{
	lib,
	colors,
	accentLevel ? "normal", # "dimmed" | "normal" | "bright"
	accentColor ? "red", # "red" | "orange" | "yellow" | "green" | "cyan" | "blue" | "purple" | "magenta"
}: let
	accentHex = colors.accent.bg.${accentLevel}.${accentColor};
	onAccentHex = colors.accent.fg.${accentLevel}.${accentColor};
	syntaxAccents = colors.accent.bg.bright;
in {
	defaultAccent = {
		level = "normal";
		color = "red";
	};

	ui = {
		bg = colors.base."0";
		surface = colors.base."1";
		overlay = colors.base."2";
		border = {
			active = accentHex;
			inactive = colors.base."4";
		};
	};
	accent = accentHex;
	text = {
		comment = colors.base."3";
		dimmed = colors.base."4";
		main = colors.base."5";
		light = colors.base."6";
		heading = colors.base."7";
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
