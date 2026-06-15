{
	inputs,
	vars,
	...
}: {
	home-manager = {
		extraSpecialArgs = {inherit inputs vars;};
		users.${vars.user.name} = {...}: {
			programs.firefox = {
				enable = true;

				policies = {
					# --- Нативная защита от трекинга ---
					EnableTrackingProtection = {
						Cryptomining = true;
						Fingerprinting = true;
						EmailTracking = true;
					};

					# --- Обновления и Фоновые службы ---
					AppAutoUpdate = false;
					BackgroundAppUpdate = false;
					DisableFirefoxStudies = true;
					DisableTelemetry = true;
					DisablePocket = true;

					# --- Отключение лишних фич ---
					DisableBuiltinPDFViewer = true;
					DisableFirefoxAccounts = false;
					DisableFirefoxScreenshots = true;
					DisableForgetButton = true;
					DisableMasterPasswordCreation = true;
					DisableProfileImport = true;
					DisableProfileRefresh = true;
					DisableSetDesktopBackground = true;
					DisableFormHistory = true;
					DisablePasswordReveal = true;
					NoDefaultBookmarks = true;

					# --- Доступ к системным страницам ---
					BlockAboutConfig = false;
					BlockAboutProfiles = false;
					BlockAboutSupport = false;

					# --- Поведение UI ---
					OverrideFirstRunPage = "";
					OverridePostUpdatePage = "";
					DontCheckDefaultBrowser = true;
					HardwareAcceleration = true;
					OfferToSaveLogins = false;
					DisplayBookmarksToolbar = "always";
					DisplayMenuBar = "default-off";
					SearchBar = "unified";

					# Корректный путь к директории загрузок
					DefaultDownloadDirectory = "/home/${vars.user.name}/Downloads";

					# --- ХАРДЛОК НАСТРОЕК (about:config) ---
					Preferences = {
						# Строгая блокировка контента
						"browser.contentblocking.category" = {
							Value = "strict";
							Status = "locked";
						};

						# Искусственный интеллект и интеграции (Полный блок)
						"browser.ai.control.linkPreviewKeyPoints" = {
							Value = "blocked";
							Status = "locked";
						};
						"browser.ai.control.pdfjsAltText" = {
							Value = "blocked";
							Status = "locked";
						};
						"browser.ai.control.smartTabGroups" = {
							Value = "blocked";
							Status = "locked";
						};
						"browser.ai.control.translations" = {
							Value = "blocked";
							Status = "locked";
						};
						"browser.ml.chat.page.footerBadge" = {
							Value = false;
							Status = "locked";
						};
						"browser.ml.chat.page.menuBadge" = {
							Value = false;
							Status = "locked";
						};
						"browser.ml.chat.shortcuts" = {
							Value = false;
							Status = "locked";
						};
						"browser.ml.linkPreview.enabled" = {
							Value = false;
							Status = "locked";
						};

						# Утилиты адресной строки (Лочим состояние)
						"browser.urlbar.suggest.calculator" = {
							Value = true;
							Status = "locked";
						};
						"browser.urlbar.quickactions.enabled" = {
							Value = false;
							Status = "locked";
						};
						"browser.urlbar.quickactions.showPrefs" = {
							Value = false;
							Status = "locked";
						};
						"browser.urlbar.shortcuts.quickactions" = {
							Value = false;
							Status = "locked";
						};
						"browser.urlbar.suggest.quickactions" = {
							Value = false;
							Status = "locked";
						};

						# Загрузки
						"browser.download.useDownloadDir" = {
							Value = false;
							Status = "locked";
						};

						# Внешний вид
						"browser.shell.checkDefaultBrowser" = {
							Value = false;
							Status = "locked";
						};
						"browser.vpn_promo.enabled" = {
							Value = false;
							Status = "locked";
						};
						"browser.compactmode.show" = {
							Value = true;
							Status = "locked";
						};

						# Безопасность: Аппаратные ключи (Yubikey)
						"security.webauth.u2f" = {
							Value = true;
							Status = "locked";
						};
						"security.webauth.webauthn" = {
							Value = true;
							Status = "locked";
						};
						"security.webauth.webauthn_enable_softtoken" = {
							Value = true;
							Status = "locked";
						};
						"security.webauth.webauthn_enable_usbtoken" = {
							Value = true;
							Status = "locked";
						};

						# Скрытые сетевые пинги телеметрии
						"toolkit.telemetry.server" = {
							Value = "data:,";
							Status = "locked";
						};
						"toolkit.telemetry.archive.enabled" = {
							Value = false;
							Status = "locked";
						};
						"toolkit.telemetry.bhrPing.enabled" = {
							Value = false;
							Status = "locked";
						};
						"toolkit.telemetry.firstShutdownPing.enabled" = {
							Value = false;
							Status = "locked";
						};
						"toolkit.telemetry.newProfilePing.enabled" = {
							Value = false;
							Status = "locked";
						};
						"toolkit.telemetry.shutdownPingSender.enabled" = {
							Value = false;
							Status = "locked";
						};
						"toolkit.telemetry.shutdownPingSender.enabledFirstsession" = {
							Value = false;
							Status = "locked";
						};
						"toolkit.telemetry.updatePing.enabled" = {
							Value = false;
							Status = "locked";
						};
						"app.normandy.api_url" = {
							Value = "";
							Status = "locked";
						};

						# Интеграция с Wayland/Niri
						"widget.dmabuf.force-enabled" = {
							Value = true;
							Status = "locked";
						};
						"widget.transparent-windows" = {
							Value = true;
							Status = "locked";
						};
						"widget.wayland.opaque-by-default" = {
							Value = false;
							Status = "locked";
						};
					};
				};
			};
		};
	};
}
