# ── Theme: cicada — role mapping ──────────────────────────────────────────────
{colors, ...}: {
	ui = {
		deep = colors.base."0"; # за стеклом / размытием
		"0" = colors.base."0";
		main = colors.base."1"; # фон окна
		"1" = colors.base."1";
		surface = colors.base."2"; # панели, статус‑бары
		"2" = colors.base."2";
		overlay = colors.base."3"; # плавающие окна / неактивные границы
		"3" = colors.base."3";
		selection = colors.base."4"; # фон выделения текста
		"4" = colors.base."4";
		highlight = colors.base."5"; # подсветка текущей строки
		"5" = colors.base."5";

		border = {
			active = colors.accent.red;
			inactive = colors.base."3";
		};
	};

	accent = colors.accent.red; # основной акцент

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
			error = colors.accent.cyan; # искажение: cyan = ошибка
			info = colors.accent.blue;
			warning = colors.accent.yellow;
			success = colors.accent.pink; # искажение: pink = успех
			match = colors.accent.purple;
		};
	};
}
