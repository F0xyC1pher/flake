{vars, ...}: {
	home-manager.users.${vars.user.name} = {
		wayland.windowManager.hyprland = {
			extraLuaFiles = {
				"07-window-rules" = {
					autoLoad = true;
					content = ''
						-- Игры
						hl.window_rule({
						  name = "disable-blur-games",
						  match = { class = "^(steam_app_|heroic|lutris|Minecraft)$" },
						  no_blur = true,
						})

						-- Steam Тоасты
						hl.window_rule({
						  name = "steam-toasts",
						  match = { class = "^(steam)$", title = "^(notificationtoasts_)" },
						  float = true,
						  move = {"monitor_w - window_w - ${toString vars.theme.gaps."in"} - ${toString vars.theme.border.size}", "monitor_h - window_h - ${toString vars.theme.gaps."in"} - ${toString vars.theme.border.size}"},
						  no_initial_focus = true,
						})

						-- Tenki
						hl.window_rule({
						  name = "tenki-float",
						  match = { class = "^(tenki)$" },
						  float = true,
						  size = "391 155",
						})

						-- Firefox PiP
						hl.window_rule({
						  name = "firefox-pip",
						  match = { title = "^(Картинка в картинке|Picture-in-Picture)$" },
						  float = true,
						  move = {"monitor_w - window_w - ${toString vars.theme.gaps."in"} - ${toString vars.theme.border.size}", "monitor_h - window_h - ${toString vars.theme.gaps."in"} - ${toString vars.theme.border.size}"},
						  no_initial_focus = true,
							content = "video",
							force_rgbx = true,
							opaque = true,
						})

						-- KeePassXC
						-- hl.window_rule({
						--   name = "keepassxc-blockout",
						--   match = { class = "^(org\\.keepassxc\\.KeePassXC)$" },
						-- })

						-- Слои (Waybar, Rofi)
						hl.layer_rule({
						  name = "bar-launcher-blur",
						  match = { namespace = "^(waybar|launcher|rofi)$" },
						  blur = true,
						})
					'';
				};
			};
		};
	};
}
