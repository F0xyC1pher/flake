{
	vars,
	lib,
	...
}: {
	home-manager.users.${vars.user.name} = {vars, ...}: let
		# Обращаемся к сгенерированной структуре цвета
		c = vars.theme.colors; # Здесь результат вашего функций-генератора

		accentColor = vars.theme.accentColor; # например, "blue" или "purple"

		# Акценты для Active
		accentActiveBg = c.accent.bg.normal.${accentColor};
		accentActiveFg = c.accent.fg.normal.${accentColor};

		# Акценты для Inactive
		accentDimmedBg = c.accent.bg.dimmed.${accentColor};
		accentDimmedFg = c.accent.fg.dimmed.${accentColor};

		# Функция форматирования цвета в #AARRGGBB с дефолтной альфой FF (100%)
		toQtColor = alpha: color: let
			cleanColor = lib.removePrefix "#" color;
			len = builtins.stringLength cleanColor;
		in
			if len == 6
			then "#${alpha}${cleanColor}"
			else color;

		# Форматирование списка цветов через запятую с пробелом для qt6ct
		formatPalette = colors: builtins.concatStringsSep ", " (map (toQtColor "ff") colors);
	in {
		qt = {
			enable = true;
			platformTheme.name = "qt6ct";

			qt6ctSettings = {
				Appearance = {
					custom_palette = true;
					standard_dialogs = "xdgdesktopportal";
					style = "kvantum-dark";
				};

				Fonts = {
					fixed = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
					general = "\"${vars.theme.font.name},${toString vars.theme.font.size},-1,5,400,0,0,0,0,0,0,0,0,0,0,1\"";
				};

				ColorScheme = {
					# Active: Нормальный яркий акцент и полная яркость интерфейса
					active_colors =
						formatPalette [
							c.base.text.active.main # 1. WindowText
							c.base.ui.active.surface # 2. Button
							c.base.ui.active.overlay # 3. Light
							c.base.ui.active.surface # 4. Midlight
							c.base.ui.active.border # 5. Dark
							c.base.ui.active.bg # 6. Mid
							c.base.text.active.main # 7. Text
							c.base.text.active.heading # 8. BrightText
							c.base.text.active.main # 9. ButtonText
							c.base.ui.active.bg # 10. Base
							c.base.ui.active.bg # 11. Window
							c.base.ui.active.border # 12. Shadow
							accentActiveBg # 13. Highlight
							accentActiveFg # 14. HighlightedText
							c.base."0D" # 15. Link (синий из base0D)
							c.base."0B" # 16. LinkVisited (зеленый из base0B)
							c.base.ui.active.overlay # 17. AlternateBase
							c.base.ui.active.surface # 18. NoRole
							c.base.ui.active.surface # 19. ToolTipBase
							c.base.text.active.main # 20. ToolTipText
							(toQtColor "80" c.base.text.active.dimmed) # 21. PlaceholderText (с 50% прозрачностью)
							accentActiveBg # 22. Accent
						];

					# Inactive: Автоматически приглушенные тона UI/Text из c.base.*.inactive
					inactive_colors =
						formatPalette [
							c.base.text.inactive.main # 1. WindowText
							c.base.ui.inactive.surface # 2. Button
							c.base.ui.inactive.overlay # 3. Light
							c.base.ui.inactive.surface # 4. Midlight
							c.base.ui.inactive.border # 5. Dark
							c.base.ui.inactive.bg # 6. Mid
							c.base.text.inactive.main # 7. Text
							c.base.text.inactive.heading # 8. BrightText
							c.base.text.inactive.main # 9. ButtonText
							c.base.ui.inactive.bg # 10. Base
							c.base.ui.inactive.bg # 11. Window
							c.base.ui.inactive.border # 12. Shadow
							accentDimmedBg # 13. Highlight
							accentDimmedFg # 14. HighlightedText
							c.base."0D" # 15. Link
							c.base."0B" # 16. LinkVisited
							c.base.ui.inactive.overlay # 17. AlternateBase
							c.base.ui.inactive.surface # 18. NoRole
							c.base.ui.inactive.surface # 19. ToolTipBase
							c.base.text.inactive.main # 20. ToolTipText
							(toQtColor "80" c.base.text.inactive.dimmed) # 21. PlaceholderText
							accentDimmedBg # 22. Accent
						];

					# Disabled: Обесцвеченные / заблокированные элементы из c.base.*.disabled
					disabled_colors =
						formatPalette [
							c.base.text.disabled.dimmed # 1. WindowText
							c.base.ui.disabled.surface # 2. Button
							c.base.ui.disabled.overlay # 3. Light
							c.base.ui.disabled.surface # 4. Midlight
							c.base.ui.disabled.border # 5. Dark
							c.base.ui.disabled.bg # 6. Mid
							c.base.text.disabled.dimmed # 7. Text
							c.base.text.disabled.heading # 8. BrightText
							c.base.text.disabled.dimmed # 9. ButtonText
							c.base.ui.disabled.bg # 10. Base
							c.base.ui.disabled.bg # 11. Window
							c.base.ui.disabled.border # 12. Shadow
							c.base.ui.disabled.overlay # 13. Highlight
							c.base.text.disabled.comment # 14. HighlightedText
							c.base.text.disabled.dimmed # 15. Link
							c.base.text.disabled.dimmed # 16. LinkVisited
							c.base.ui.disabled.overlay # 17. AlternateBase
							c.base.ui.disabled.surface # 18. NoRole
							c.base.ui.disabled.surface # 19. ToolTipBase
							c.base.text.disabled.dimmed # 20. ToolTipText
							(toQtColor "66" c.base.text.disabled.comment) # 21. PlaceholderText
							c.base.ui.disabled.border # 22. Accent
						];
				};
			};
		};
	};
}
