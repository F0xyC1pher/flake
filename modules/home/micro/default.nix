{ lib, config, pkgs, inputs, vars, ... }:
{
	programs.micro = {
		enable = true;
		settings = {
			colorscheme = "the-Me";  # Убедитесь, что использует вашу схему (Stylix должен установить сам, но override на случай)
			showchars = "itab=│";  # Показывать отступы как │ (для spaces и tabs; настройте символ по вкусу, например "┊" или "┆")
			hltrailingws = true;  # Дополнительно: Подсвечивать trailing whitespace (для видимости лишних пробелов)
			# Опционально: Если используете tabs как spaces
			tabstospaces = false;  # Конвертировать tabs в spaces (default false)
			tabsize = 4;  # Ширина tab
		};
	};
}
