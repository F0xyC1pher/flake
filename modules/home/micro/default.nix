{ lib, config, pkgs, inputs, vars, ... }:
{
	programs.micro = {
		enable = true;
		settings = {
			showchars = "itab=│";  # Показывать отступы как │ (для spaces и tabs; настройте символ по вкусу, например "┊" или "┆")
			hltrailingws = false;  # Подсвечивать trailing whitespace (для видимости лишних пробелов)
			tabstospaces = false;  # Конвертировать tabs в spaces (default false)
			tabsize = 4;  # Ширина tab
		};
	};
}
