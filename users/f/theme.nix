{vars, ...}: {
	ui = {
		# Слой 0-5: Фундамент и Глубина
		deep = vars.colors.base."0"; # То, что за стеклом (блюр)
		"0" = vars.colors.base."0"; # То, что за стеклом (блюр)
		main = vars.colors.base."1"; # Фон терминала/окон
		"1" = vars.colors.base."1"; # Фон терминала/окон
		surface = vars.colors.base."2"; # Панели, статусбары
		"2" = vars.colors.base."2"; # Панели, статусбары
		overlay = vars.colors.base."3"; # Плавающие окна (fuzzel) / Неактивные границы
		"3" = vars.colors.base."3"; # Плавающие окна (fuzzel) / Неактивные границы
		selection = vars.colors.base."4"; # Выделение текста (фон)
		"4" = vars.colors.base."4"; # Выделение текста (фон)
		highlight = vars.colors.base."5"; # Подсветка текущей строки (line-hl)
		"5" = vars.colors.base."5"; # Подсветка текущей строки (line-hl)

		border = {
			active = vars.colors.theme.accent; # Соответствует акцентному цвету
			inactive = vars.colors.base."3"; # Дублирует overlay для консистентности
		};
	};

	accent = vars.colors.accent.red;

	text = {
		# Слой 6-8: Технический текст и Разделители
		comment = vars.colors.base."6";
		separator = vars.colors.base."7";
		indent = vars.colors.base."8";
		# Слой 9-F: Читаемый текст (Градиент яркости)
		submerged = vars.colors.base."9"; # Текст иконок / Неактивные вкладки
		faint = vars.colors.base."a"; # Вторичная информация (размер файлов)
		sub-main = vars.colors.base."b"; # Текст в статусбаре (чуть тусклее основного)
		dimmed = vars.colors.base."c"; # Опциональный уровень (почти основной)
		main = vars.colors.base."d"; # Основной текст (чтение)
		primary = vars.colors.base."d"; # Основной текст (чтение)
		highlight = vars.colors.base."e"; # Выделенный текст в мануалах/жирный
		heading = vars.colors.base."f"; # Чистый свет (Заголовки / Белый)

		onAccent = vars.colors.accent.green;
		match = vars.colors.accent.green;

		syntax = {
			keyword = vars.colors.accent.purple;
			number = vars.colors.accent.orange;
			function = vars.colors.accent.blue;
			string = vars.colors.accent.green;
			error = vars.colors.accent.cyan;
			info = vars.colors.accent.blue;
			warning = vars.colors.accent.yellow;
			success = vars.colors.accent.pink;
			match = vars.colors.theme.text.submerged;
		};
	};
}
