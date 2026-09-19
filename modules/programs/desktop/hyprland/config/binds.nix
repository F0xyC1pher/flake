{
	vars,
	lib,
	...
}: {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"01-binds" = {
					autoLoad = true;
					content = ''
						local mainMod = "SUPER"
						-- Переменные окружения/приложений
						local terminal = "${vars.app.terminal or "kitty"}"
						local fileManager = terminal .. " yazi"
						local menu = "${vars.app.launcher} ${lib.optionalString (vars.app.launcher == "rofi") "-show drun"}"

						hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
						-- Приложения
						hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
						hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
						hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
						hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(fileManager))
						hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
						hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))

						-- Буфер обмена
						${lib.optionalString (vars.hasProgram "rofi") ''hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("rofi -modi clipboard:cliphist-rofi-img -show clipboard -show-icons"))''}
						${lib.optionalString (vars.hasProgram "fuzzel") ''hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("cliphist-fuzzel-img"))''}

						-- Управление окнами и сессией
						local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
						closeWindowBind:set_enabled(true)

						hl.bind(mainMod .. " + Space", hl.dsp.window.float({ action = "toggle" }))
						hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle", layout_aware = true }))
						hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

						hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("swaylock"))
						hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
						hl.bind("CTRL + ALT + Delete", hl.dsp.exit())
						hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
						hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprctl dispatch dpms off"))

						-- Навигация и Управление Лейаутом
						hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
						hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
						hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
						hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

						hl.bind(mainMod .. " + Left",  hl.dsp.focus({ direction = "left" }))
						hl.bind(mainMod .. " + Right", hl.dsp.focus({ direction = "right" }))
						hl.bind(mainMod .. " + Up",    hl.dsp.focus({ direction = "up" }))
						hl.bind(mainMod .. " + Down",  hl.dsp.focus({ direction = "down" }))

						-- Кастомные действия лейаута
						hl.bind(mainMod .. " + I", hl.dsp.layout("colresize +conf"))

						-- Перемещение окон
						hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "left" }))
						hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "right" }))
						hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "up" }))
						hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "down" }))
						hl.bind(mainMod .. " + SHIFT + H",     hl.dsp.window.move({ direction = "left" }))
						hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.window.move({ direction = "right" }))
						hl.bind(mainMod .. " + SHIFT + K",     hl.dsp.window.move({ direction = "up" }))
						hl.bind(mainMod .. " + SHIFT + J",     hl.dsp.window.move({ direction = "down" }))

						-- Воркспейсы 1..10 (0 мапится на 10)
						for i = 1, 10 do
							local key = i % 10
							hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
							hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
						end

						-- Специальный воркспейсы (Scratchpad)
						hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
						hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

						-- Скриншоты
						hl.bind("Print",         hl.dsp.exec_cmd("hyprshot -m region"))
						hl.bind("CTRL + Print",  hl.dsp.exec_cmd("hyprshot -m output"))
						hl.bind("ALT + Print",   hl.dsp.exec_cmd("hyprshot -m window"))

						-- Колесико мыши для смены воркспейсов
						hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ direction = "down" }))
						hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ direction = "up" }))
						hl.bind(mainMod .. " + SHIFT + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
						hl.bind(mainMod .. " + SHIFT + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

						-- Перетаскивание и ресайз мышью
						hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
						hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

						-- Мультимедиа и Звук (PipeWire / wpctl)
						hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"), { locked = true, repeating = true })
						hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"),       { locked = true, repeating = true })
						hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),        { locked = true, repeating = true })
						hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),      { locked = true, repeating = true })

						-- Плеер (playerctl)
						hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
						hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
						hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
						hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

						-- Яркость
						hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
						hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
					'';
				};
			};
		};
	};
}
