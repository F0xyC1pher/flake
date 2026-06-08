{
	inputs,
	vars,
	lib,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			xdg.configFile."niri/window-rules.kdl".text = ''
				// syntax: kdl
				//
				// ────────────── Window Rules  ──────────────
				// Window rules let you adjust behavior for individual windows.
				// Find more information on the wiki:
				// https://yalter.github.io/niri/Configuration:-Window-Rules
				window-rule {
					geometry-corner-radius 0
					clip-to-geometry true
					open-maximized true
					draw-border-with-background false
				}

				${
					# Вставляем правило только если блюр включен, а xray специально выключен в vars
					lib.optionalString (vars.theme.blur.enable && !vars.theme.blur.xray.enable) ''
						window-rule {
							background-effect {
								xray false
							}
						}
						window-rule {
							match app-id="dev.zed.Zed"
							background-effect {
								blur true
								xray false
							}
						}
						      window-rule {
								match app-id="^zen-twilight$"
							background-effect {
								blur true
								xray false
							}
						}
						window-rule {
							match app-id="codium"
							background-effect {
								blur true
								xray false
							}
						}
					''
				}

				// Steam Notifications in right-down corner and without focus
				window-rule {
					match app-id="steam" title=r#"^notificationtoasts_\d+_desktop$"#
					default-floating-position x=10 y=10 relative-to="bottom-right"
					open-floating true
					open-focused false
				}

				window-rule {
					match app-id="blobdrop"
					open-floating true
				}

				window-rule {
					match app-id="tenki"
					open-floating true
					min-width 391
					max-width 391
					min-height 155
					max-height 155
				}

				// Indicate active windows with red colors.
				// window-rule {
				//	match is-active=true

					// shadow {
						// color "${vars.theme.style.accent}a8"
					// }
				// }

				/-window-rule {
					match title="TrayControl" app-id="AIMP"
					match title="TrayControl" app-id="Aimp"
					border {
						off
					}
					shadow {
						off
					}
					default-floating-position x=0 y=0 relative-to="bottom"
					open-floating true
					min-width 1910
					max-width 1910
					min-height 54
					max-height 54
				}

				// Открывать картинку-в-картинке проигрывателя Firefox в плавающем состоянии по дефолту.
				window-rule {
					// This app-id regular expression will work for both:
					// - host Firefox (app-id is "firefox")
					// - Flatpak Firefox (app-id is "org.mozilla.firefox")
					match title="^Картинка в картинке$"
					match title="Picture-in-Picture"
					open-focused false
					open-floating true
					default-floating-position x=20 y=20 relative-to="bottom-right"
				}

				// Блокировать менеджеры паролей от демонстрации экрана.
				window-rule {
					match app-id=r#"^org\.keepassxc\.KeePassXC$"#

					block-out-from "screen-capture"

					// Или от скринкаста (разрешить скрины но запретить демонстрацию).
					// block-out-from "screencast"
				}
			'';
		};
	};
}
