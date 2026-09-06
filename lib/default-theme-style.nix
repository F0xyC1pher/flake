{
	lib,
	colors,
	accentLevel ? "normal",
	accentColor ? "red",
}: let
	accentHex = colors.accent.bg.${accentLevel}.${accentColor} or colors.accent.bg.normal.red;
	onAccentHex = colors.accent.fg.${accentLevel}.${accentColor} or colors.accent.fg.normal.red;
	syntaxAccents = colors.accent.bg.bright;
in {
	ui = {
		bg = colors.base."00";
		surface = colors.base."01";
		overlay = colors.base."02";
		border = {
			active = accentHex;
			inactive = colors.base."04";
		};
	};

	accent = accentHex;

	text = {
		comment = colors.base."03";
		dimmed = colors.base."04";
		main = colors.base."05";
		light = colors.base."06";
		heading = colors.base."07";
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
