{ lib, config, pkgs, inputs, vars, ... }:
{
# ========== NIRI ==========
	programs.niri = {
		settings = {
			window-rules = {
				# Максимизировать все окна по умолчанию
				default = {
					open-maximized = true;
					draw-border-with-background = false;
				};

				# Steam notifications в правом нижнем углу
				steam-notifications = {
					match = { app-id = "steam"; title = "^notificationtoasts_\\d+_desktop$"; };
					open-floating = true;
					open-focused = false;
					default-floating-position = { x = 10; y = 10; relative-to = "bottom-right"; };
				};

				# blobdrop всегда плавающее
				blobdrop = {
					match = { app-id = "blobdrop"; };
					open-floating = true;
				};

				# tenki фиксированный размер
				tenki = {
					match = { app-id = "tenki"; };
					open-floating = true;
					min-width = 391;
					max-width = 391;
					min-height = 155;
					max-height = 155;
				};

				# Активные окна с красной тенью
				active-windows = {
					match = { is-active = true; };
					shadow = { color = "rgba(231,16,32,0.4)"; };
				};

				# Панель AIMP внизу, без бордера и тени
				aimp-tray = {
					match = { title = "TrayControl"; app-id = "AIMP|Aimp"; };
					border = { off = true; };
					shadow = { off = true; };
					open-floating = true;
					default-floating-position = { x = 0; y = 0; relative-to = "bottom"; };
					min-width = 1910; max-width = 1910;
					min-height = 54; max-height = 54;
				};

				# Картинка в картинке Firefox
				pip-firefox = {
					match = { title = "^Картинка в картинке$"; };
					open-floating = true;
					open-focused = false;
					default-floating-position = { x = 20; y = 20; relative-to = "bottom-right"; };
				};

				# KeePassXC — блокировать демонстрацию экрана
				keepassxc = {
					match = { app-id = "^org\\.keepassxc\\.KeePassXC$"; };
					block-out-from = "screen-capture";
				};
			};
		};
	};
}
