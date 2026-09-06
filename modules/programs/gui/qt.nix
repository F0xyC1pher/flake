{vars, ...}: {
	home-manager.users.${vars.user.name} = {vars, ...}: let
		t = vars.theme.style;
		c = vars.theme.colors;

		accentColor = vars.theme.accentColor;

		# Акценты уровня dimmed из генератора темы base16To56
		accentDimmedBg = c.accent.bg.dimmed.${accentColor};
		accentDimmedFg = c.accent.fg.dimmed.${accentColor};

		# Функция объединения цветов через '@' для INI-файла qt6ct
		formatPalette = colors: builtins.concatStringsSep "@" colors;
	in {
		qt = {
			enable = true;
			platformTheme.name = "qt6ct";

			# style.name = "kvantum-dark";

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
					# Active: Нормальный яркий акцент и тексты
					active_colors =
						formatPalette [
							t.text.main # 1. WindowText
							t.ui.surface # 2. Button
							t.ui.overlay # 3. Light
							t.ui.surface # 4. Midlight
							t.ui.border.inactive # 5. Dark
							t.ui.bg # 6. Mid
							t.text.main # 7. Text
							t.text.heading # 8. BrightText
							t.text.main # 9. ButtonText
							t.ui.bg # 10. Base
							t.ui.bg # 11. Window
							t.ui.border.inactive # 12. Shadow
							t.accent # 13. Highlight (Normal Accent BG)
							t.text.onAccent # 14. HighlightedText (Normal Accent FG)
							t.text.syntax.function # 15. Link
							t.text.syntax.string # 16. LinkVisited
							t.ui.overlay # 17. AlternateBase
							t.ui.surface # 18. NoRole
							t.ui.surface # 19. ToolTipBase
							t.text.main # 20. ToolTipText
							t.text.dimmed # 21. PlaceholderText
							t.accent # 22. Accent
						];

					# Inactive: Dimmed-акценты для неактивного окна
					inactive_colors =
						formatPalette [
							t.text.dimmed # 1. WindowText
							t.ui.surface # 2. Button
							t.ui.overlay # 3. Light
							t.ui.surface # 4. Midlight
							t.ui.border.inactive # 5. Dark
							t.ui.bg # 6. Mid
							t.text.dimmed # 7. Text
							t.text.dimmed # 8. BrightText
							t.text.dimmed # 9. ButtonText
							t.ui.bg # 10. Base
							t.ui.bg # 11. Window
							t.ui.border.inactive # 12. Shadow
							accentDimmedBg # 13. Highlight (Dimmed Accent BG)
							accentDimmedFg # 14. HighlightedText (Dimmed Accent FG)
							t.text.syntax.function # 15. Link
							t.text.syntax.string # 16. LinkVisited
							t.ui.overlay # 17. AlternateBase
							t.ui.surface # 18. NoRole
							t.ui.surface # 19. ToolTipBase
							t.text.dimmed # 20. ToolTipText
							t.text.comment # 21. PlaceholderText
							accentDimmedBg # 22. Accent
						];

					# Disabled: Исключительно серые/приглушенные роли интерфейса
					disabled_colors =
						formatPalette [
							t.text.dimmed # 1. WindowText
							t.ui.surface # 2. Button
							t.ui.overlay # 3. Light
							t.ui.surface # 4. Midlight
							t.ui.border.inactive # 5. Dark
							t.ui.bg # 6. Mid
							t.text.dimmed # 7. Text
							t.text.dimmed # 8. BrightText
							t.text.dimmed # 9. ButtonText
							t.ui.bg # 10. Base
							t.ui.bg # 11. Window
							t.ui.border.inactive # 12. Shadow
							t.ui.overlay # 13. Highlight (Нейтральная подложка)
							t.text.comment # 14. HighlightedText (Приглушенный текст)
							t.text.dimmed # 15. Link
							t.text.dimmed # 16. LinkVisited
							t.ui.overlay # 17. AlternateBase
							t.ui.surface # 18. NoRole
							t.ui.surface # 19. ToolTipBase
							t.text.dimmed # 20. ToolTipText
							t.text.comment # 21. PlaceholderText
							t.ui.border.inactive # 22. Accent (Нейтральный рамка/акцент)
						];
				};
			};
		};
	};
}
